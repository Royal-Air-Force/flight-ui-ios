//
//  InputField.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI
import Combine

public struct CustomInputField: View {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @FocusState var isFocused: Bool

    @Binding var text: String
    var placeholder: String?
    var topLabel: String?
    var topLabelSpacer: Bool
    var bottomLabelConfig: BottomLabelConfig
    var formatter: ((String) -> String)?
    var validator: ((String) -> Void)?
    var filter: RegexFilter?
    var maxCharacterCount: Int?
    var customKeyboard: UIInputViewController?
    var keyboardType: UIKeyboardType

    public init(
        text: Binding<String>,
        placeholder: String? = nil,
        topLabel: String? = nil,
        topLabelSpacer: Bool = false,
        bottomLabelConfig: BottomLabelConfig = .init(isVisible: false),
        formatter: ((String) -> String)? = nil,
        filter: RegexFilter? = nil,
        validator: ((String) -> Void)? = nil,
        maxCharacterCount: Int? = nil,
        customKeyboard: UIInputViewController? = nil,
        keyboardType: UIKeyboardType = .default
    ) {
        self._text = text
        self.placeholder = placeholder
        self.topLabel = topLabel
        self.topLabelSpacer = topLabelSpacer
        self.bottomLabelConfig = bottomLabelConfig
        self.formatter = formatter
        self.validator = validator
        self.filter = filter
        self.maxCharacterCount = maxCharacterCount
        self.customKeyboard = customKeyboard
        self.keyboardType = keyboardType
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid0_5x) {
            buildTopLabel()
            buildTextField()
            BottomLabel(bottomLabelConfig)
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
        Group {
            if let customKeyboard = customKeyboard {
                CustomUIKitTextField(
                    text: $text,
                    placeholder: placeholder,
                    keyboardType: keyboardType,
                    customKeyboard: customKeyboard
                )
            } else {
                TextField(text: $text) {
                    if let placeholderText = placeholder {
                        Text(placeholderText)
                            .foregroundColor(theme.color.primary.opacity(isEnabled ? InputFieldDefaults.hintOpacity : InputFieldDefaults.disabledOpacity))
                    }
                }
            }
        }
        .keyboardType(keyboardType)
        .onReceive(Just(text)) { newValue in
            if let regex = filter?.regex {
                let replaced = newValue.replacingOccurrences(
                    of: regex,
                    with: "",
                    options: .regularExpression
                )
                if replaced != newValue {
                    self.text = replaced
                }
            }
            // Limit character count
            if let maxCount = maxCharacterCount {
                if text.count > maxCount {
                    text = String(text.prefix(maxCount))
                }
            }
        }
        .focused($isFocused)
        .onChange(of: isFocused) { newFocus in
            if !newFocus {
                if let format = formatter {
                    text = format(text)
                }
                if let valid = validator {
                    valid(text)
                }
            }
        }
    }
}

private class CustomInputTextField: UITextField {
    var customInputViewController: UIInputViewController?
    
    override var inputViewController: UIInputViewController? {
        return customInputViewController
    }
}

private struct CustomUIKitTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String?
    var keyboardType: UIKeyboardType
    var customKeyboard: UIInputViewController
    
    func makeUIView(context: Context) -> CustomInputTextField {
        let textField = CustomInputTextField()
        textField.delegate = context.coordinator
        textField.keyboardType = keyboardType
        textField.placeholder = placeholder
        
        textField.customInputViewController = customKeyboard
        
        textField.addTarget(
            context.coordinator,
            action: #selector(Coordinator.textFieldDidChange(_:)),
            for: .editingChanged
        )
        
        return textField
    }
    
    func updateUIView(_ uiView: CustomInputTextField, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        uiView.keyboardType = keyboardType
        uiView.customInputViewController = customKeyboard
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomUIKitTextField
        
        init(_ parent: CustomUIKitTextField) {
            self.parent = parent
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}
