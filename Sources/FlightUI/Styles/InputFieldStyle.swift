import SwiftUI

public struct InputFieldStyle: TextFieldStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @FocusState private var isFocused: Bool

    var inputFieldState: InputFieldState
    var inputFieldConfig: InputFieldConfig

    public init(
        _ inputFieldState: InputFieldState,
        inputFieldConfig: InputFieldConfig = InputFieldConfig()
    ) {
        self.inputFieldState = inputFieldState
        self.inputFieldConfig = inputFieldConfig
    }

    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundColor(getFontColor())
            .fontStyle(inputFieldConfig.fontStyle ?? theme.font.bodyBold)
            .frame(maxWidth: .infinity, minHeight: theme.size.large)
            .padding(.horizontal, theme.padding.grid2x)
            .background(getFieldBackgroundColor())
            .cornerRadius(getCornerRadius())
            .overlay {
                RoundedRectangle(cornerRadius: getCornerRadius(), style: .continuous)
                    .strokeBorder(getFieldBorderColor(), lineWidth: getFieldBorderSize())
            }
            .disabled(inputFieldState == .advisory)
            .focused($isFocused)
            .onTapGesture {
                isFocused = true
            }
    }

    private func getFontColor() -> Color {
        if let overrideColor = inputFieldConfig.fontColor {
            return overrideColor
        }

        switch inputFieldState {
        case .advisory:
            return theme.color.primary
        default:
            return theme.color.inputOutput.opacity(isEnabled ? 1 : InputFieldDefaults.disabledOpacity)
        }
    }

    private func getFieldBackgroundColor() -> Color {
        if !isEnabled {
            return theme.color.surfaceHigh.opacity(InputFieldDefaults.disabledOpacity)
        }

        if let overrideColor = inputFieldConfig.backgroundColor {
            return overrideColor
        }

        switch inputFieldState {
        case .default:
            return theme.color.surfaceHigh
        case .advisory:
            return theme.color.surfaceHigh
        case .nominal:
            return theme.color.nominal.opacity(InputFieldDefaults.stateBackgroundOpacity)
        case .caution:
            return theme.color.caution.opacity(InputFieldDefaults.stateBackgroundOpacity)
        case .warning:
            return theme.color.warning.opacity(InputFieldDefaults.stateBackgroundOpacity)
        }
    }

    private func getCornerRadius() -> CGFloat {
        if let overrideRadius = inputFieldConfig.cornerRadius {
            return overrideRadius
        }
        return theme.radius.medium
    }

    private func getFieldBorderColor() -> Color {
        if let overrideColor = inputFieldConfig.borderColor {
            return overrideColor
        }

        switch inputFieldState {
        case .default:
            return theme.color.surfaceHigh
        case .advisory:
            return theme.color.primary.opacity(isEnabled ? 1 : InputFieldDefaults.disabledOpacity)
        case .nominal:
            return theme.color.nominal.opacity(isEnabled ? 1 : InputFieldDefaults.disabledOpacity)
        case .caution:
            return theme.color.caution.opacity(isEnabled ? 1 : InputFieldDefaults.disabledOpacity)
        case .warning:
            return theme.color.warning.opacity(isEnabled ? 1 : InputFieldDefaults.disabledOpacity)
        }
    }

    private func getFieldBorderSize() -> CGFloat {
        switch inputFieldState {
        case .nominal, .caution, .warning:
            return theme.size.border
        default:
            return 0
        }
    }
}
