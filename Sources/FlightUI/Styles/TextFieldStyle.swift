import SwiftUI

private class Defaults {
    static let disabledOpacity: CGFloat = 0.38
    static let stateBackgroundOpacity: CGFloat = 0.08
    static let hintOpacity: CGFloat = 0.54
}

public struct CustomTextFieldConfig {

}

public struct WrappedTextField: View {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool

    @Binding var text: String
    var topLabel: String?
    var advisoryLabel: String?
    var placeholder: String?

    public init(
        text: Binding<String>,
        topLabel: String? = nil,
        advisoryLabel: String? = nil,
        placeholder: String? = nil
    ) {
        self._text = text
        self.topLabel = topLabel
        self.advisoryLabel = advisoryLabel
        self.placeholder = placeholder
    }

    public var body: some View {
        VStack(alignment: .leading) {
            if topLabel != nil {
                Text(topLabel!).fontStyle(theme.font.caption1).foregroundColor(theme.color.primary)
            }
            if placeholder != nil {
                HStack {
                    TextField(text: $text) {
                        Text(placeholder!).foregroundColor(theme.color.primary.opacity(isEnabled ? Defaults.hintOpacity : Defaults.disabledOpacity))
                    }
                }
            } else {
                TextField("", text: $text)
            }
            if advisoryLabel != nil {
                Text(advisoryLabel!).fontStyle(theme.font.caption2).foregroundColor(theme.color.primary)
            }
        }
    }
}

public enum TextFieldState {
    case `default`
    case advisory
    case nominal
    case caution
    case warning
}

public struct CustomTextFieldStyle: TextFieldStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @FocusState private var isFocused: Bool

    var textFieldState: TextFieldState

    public init(
        _ textFieldState: TextFieldState
    ) {
        self.textFieldState = textFieldState
    }

    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundColor(getFontColor())
            .fontStyle(theme.font.bodyBold)
            .frame(maxWidth: .infinity, minHeight: theme.size.large)
            .padding(.horizontal, theme.padding.grid2x)
            .background(getFieldBackgroundColor())
            .cornerRadius(theme.radius.medium)
            .overlay {
                RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous)
                    .strokeBorder(getFieldBorderColor(), lineWidth: getFieldBorderSize())
            }
            .disabled(textFieldState == .advisory)
            .focused($isFocused)
            .onTapGesture {
                isFocused = true
            }
    }

    private func getFieldBackgroundColor() -> Color {
        if !isEnabled {
            return theme.color.surfaceHigh.opacity(Defaults.disabledOpacity)
        }

        switch textFieldState {
        case .default:
            return theme.color.surfaceHigh
        case .advisory:
            return theme.color.surfaceHigh
        case .nominal:
            return theme.color.nominal.opacity(Defaults.stateBackgroundOpacity)
        case .caution:
            return theme.color.caution.opacity(Defaults.stateBackgroundOpacity)
        case .warning:
            return theme.color.warning.opacity(Defaults.stateBackgroundOpacity)
        }
    }

    private func getFieldBorderSize() -> CGFloat {
        if case .default = textFieldState {
            if !isEnabled {
                return 0
            }
        }
        if case .advisory = textFieldState {
            return 0
        }
        return theme.size.border
    }

    private func getFieldBorderColor() -> Color {
        switch textFieldState {
        case .default:
            return theme.color.surfaceHigh
        case .advisory:
            return theme.color.primary.opacity(isEnabled ? 1 : Defaults.disabledOpacity)
        case .nominal:
            return theme.color.nominal.opacity(isEnabled ? 1 : Defaults.disabledOpacity)
        case .caution:
            return theme.color.caution.opacity(isEnabled ? 1 : Defaults.disabledOpacity)
        case .warning:
            return theme.color.warning.opacity(isEnabled ? 1 : Defaults.disabledOpacity)
        }
    }

    private func getFontColor() -> Color {
        switch textFieldState {
        case .advisory:
            return theme.color.primary
        default:
            return theme.color.inputOutput
        }
    }
}
