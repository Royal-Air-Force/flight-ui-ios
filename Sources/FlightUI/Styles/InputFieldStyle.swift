//
//  InputFieldStyle.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

public struct InputFieldStyle: TextFieldStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @FocusState private var isFocused: Bool

    var inputFieldState: InputAlertingState
    var inputFieldConfig: InputFieldConfig

    public init(
        _ inputFieldState: InputAlertingState,
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
            return theme.color.surfaceHigh.opacity(InputFieldDefaults.advisoryOpacity)
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
            return theme.color.primary.opacity(InputFieldDefaults.advisoryBorderOpacity)
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
        case .advisory:
            return 1
        default:
            return 0
        }
    }
}

#if DEBUG

struct InputFieldStyle_Previews: PreviewProvider {
    static var theme: Theme = Theme(baseScheme: .dark)

    static var previews: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid2x) {
            HStack {
                InputField(text: .constant("Disabled Style"))
                    .textFieldStyle(.default)
                InputField(text: .constant("Default Disabled Style"))
                    .textFieldStyle(.default)
                    .disabled(true)
            }
            InputField(text: .constant("Advisory Style"))
                .textFieldStyle(.advisory)
            HStack {
                InputField(text: .constant("Nominal Style"))
                    .textFieldStyle(.nominal)
                InputField(text: .constant("Nominal Disabled Style"))
                    .textFieldStyle(.nominal)
                    .disabled(true)
            }
            HStack {
                InputField(text: .constant("Caution Style"))
                    .textFieldStyle(.caution)
                InputField(text: .constant("Caution Disabled Style"))
                    .textFieldStyle(.caution)
                    .disabled(true)
            }
            HStack {
                InputField(text: .constant("Warning Style"))
                    .textFieldStyle(.warning)
                InputField(text: .constant("Warning Disabled Style"))
                    .textFieldStyle(.warning)
                    .disabled(true)
            }
        }
        .environmentObject(theme)
        .previewDisplayName("Input Field Style")
        .preferredColorScheme(theme.baseScheme)
    }
}

#endif
