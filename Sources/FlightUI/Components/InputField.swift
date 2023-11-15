import SwiftUI
import Combine

public struct InputField: View {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @FocusState private var isFocused: Bool

    @Binding var text: String
    var placeholder: String?
    var topLabel: String?
    var topLabelSpacer: Bool
    var advisoryLabel: AdvisoryLabel?
    var advisoryLabelSpacer: Bool
    var formatter: ((String) -> String)?

    public init(
        text: Binding<String>,
        placeholder: String? = nil,
        topLabel: String? = nil,
        topLabelSpacer: Bool = false,
        advisoryLabel: AdvisoryLabel? = nil,
        advisoryLabelSpacer: Bool = false,
        formatter: ((String) -> String)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.topLabel = topLabel
        self.topLabelSpacer = topLabelSpacer
        self.advisoryLabel = advisoryLabel
        self.advisoryLabelSpacer = advisoryLabelSpacer
        self.formatter = formatter
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid0_5x) {
            buildTopLabel()
            buildTextField()
            buildAdvisoryLabel()
        }
    }

    @ViewBuilder
    private func buildTopLabel() -> some View {
        if let top = topLabel {
            Text(top)
                .foregroundColor(theme.color.primary)
                .fontStyle(theme.font.subhead)
        } else if topLabelSpacer {
            Text("-")
                .foregroundColor(theme.color.surfaceHigh.opacity(0))
                .fontStyle(theme.font.subhead)
        }
    }

    @ViewBuilder
    private func buildTextField() -> some View {
        if let placeholderText = placeholder {
            TextField(text: $text) {
                Text(placeholderText)
                    .foregroundColor(theme.color.primary.opacity(isEnabled ? InputFieldDefaults.hintOpacity : InputFieldDefaults.disabledOpacity))
            }
            .focused($isFocused)
            .onChange(of: isFocused) { newFocus in
                if !newFocus, let format = formatter {
                    text = format(text)
                }
            }
        } else {
            TextField("", text: $text)
                .focused($isFocused)
                .onChange(of: isFocused) { newFocus in
                    if !newFocus, let format = formatter {
                        text = format(text)
                    }
                }
        }
    }

    @ViewBuilder
    private func buildAdvisoryLabel() -> some View {
        if let advisory = advisoryLabel {
            Text(advisory.text)
                .foregroundColor(getLabelColor(advisory.state))
                .fontStyle(theme.font.caption1)
                .padding(.horizontal, theme.padding.grid2x)
        } else if advisoryLabelSpacer {
            Text("-")
                .foregroundColor(theme.color.surfaceHigh.opacity(0))
                .fontStyle(theme.font.caption1)
        }
    }

    private func getLabelColor(_ state: InputFieldState) -> Color {
        switch state {
        case .caution:
            return theme.color.caution
        case .warning:
            return theme.color.warning
        default:
            return theme.color.secondary
        }
    }
}

public struct AdvisoryLabel {
    var text: String
    var state: InputFieldState

    public init(_ text: String,
                show: Bool = true,
                state: InputFieldState = .advisory) {
        self.text = text
        self.state = state
    }
}
