//
//  InputField.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI
import Combine

public struct AccessoryViewContext<AccessoryView: View> {
    var isVisible: Bool
    var view: AccessoryView
    
    public init(
        isVisible: Bool = false,
        view: AccessoryView
    ){
        self.isVisible = isVisible
        self.view = view
    }
}

public struct InputField<AccessoryView: View>: View {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @FocusState var isFocused: Bool

    @Binding var text: String
    var placeholder: String?
    var topLabel: String?
    var topLabelSpacer: Bool
    var bottomLabelConfig: BottomLabelConfig
    var accessoryViewContext: AccessoryViewContext<AccessoryView>?
    var formatter: ((String) -> String)?
    var validator: ((String) -> Void)?
    var filter: RegexFilter?
    var maxCharacterCount: Int?
    var customKeyboard: UIInputViewController?
    var keyboardType: UIKeyboardType = .default

    public init(
        text: Binding<String>,
        placeholder: String? = nil,
        topLabel: String? = nil,
        topLabelSpacer: Bool = false,
        bottomLabelConfig: BottomLabelConfig = .init(isVisible: false),
        accessoryViewContext: AccessoryViewContext<AccessoryView>? = nil,
        formatter: ((String) -> String)? = nil,
        filter: RegexFilter? = nil,
        validator: ((String) -> Void)? = nil,
        maxCharacterCount: Int? = nil,
        customKeyboard: UIInputViewController? = nil,
    ){
        self._text = text
        self.placeholder = placeholder
        self.topLabel = topLabel
        self.topLabelSpacer = topLabelSpacer
        self.bottomLabelConfig = bottomLabelConfig
        self.accessoryViewContext = accessoryViewContext
        self.formatter = formatter
        self.validator = validator
        self.filter = filter
        self.maxCharacterCount = maxCharacterCount
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid0_5x) {
            buildTopLabel()
            buildTextField()
            BottomLabel(bottomLabelConfig, accessoryViewContext: accessoryViewContext)
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
                UIKitTextField(
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
            if let filter = filter {
                // Filter out unwanted characters using the RegexFilter
                let filtered = newValue.filter { char in
                    String(char).range(of: filter.regex, options: .regularExpression) != nil
                }
                if filtered != newValue {
                    self.text = filtered
                }
            }
                
            // Limit character count
            if let maxCount = maxCharacterCount, text.count > maxCount {
                text = String(text.prefix(maxCount))
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

extension InputField where AccessoryView == EmptyView {
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
    ) {
        self._text = text
        self.placeholder = placeholder
        self.topLabel = topLabel
        self.topLabelSpacer = topLabelSpacer
        self.bottomLabelConfig = bottomLabelConfig
        self.accessoryViewContext = nil
        self.formatter = formatter
        self.validator = validator
        self.filter = filter
        self.maxCharacterCount = maxCharacterCount
    }
}

extension InputField where AccessoryView == Text {
    public init(
        text: Binding<String>,
        placeholder: String? = nil,
        topLabel: String? = nil,
        topLabelSpacer: Bool = false,
        bottomLabelConfig: BottomLabelConfig = .init(isVisible: false),
        accessoryViewContext: AccessoryViewContext<Text>,
        formatter: ((String) -> String)? = nil,
        filter: RegexFilter? = nil,
        validator: ((String) -> Void)? = nil,
        maxCharacterCount: Int? = nil,
        customKeyboard: UIInputViewController? = nil,
    ) {
        self._text = text
        self.placeholder = placeholder
        self.topLabel = topLabel
        self.topLabelSpacer = topLabelSpacer
        self.bottomLabelConfig = bottomLabelConfig
        self.accessoryViewContext = accessoryViewContext
        self.formatter = formatter
        self.validator = validator
        self.filter = filter
        self.maxCharacterCount = maxCharacterCount
    }
}

extension InputField {
    public init<Label: View>(
        text: Binding<String>,
        placeholder: String? = nil,
        topLabel: String? = nil,
        topLabelSpacer: Bool = false,
        bottomLabelConfig: BottomLabelConfig = .init(isVisible: false),
        accessoryViewContext: AccessoryViewContext<Button<Label>>,
        formatter: ((String) -> String)? = nil,
        filter: RegexFilter? = nil,
        validator: ((String) -> Void)? = nil,
        maxCharacterCount: Int? = nil,
        customKeyboard: UIInputViewController? = nil
    ) where AccessoryView == Button<Label> {
        self._text = text
        self.placeholder = placeholder
        self.topLabel = topLabel
        self.topLabelSpacer = topLabelSpacer
        self.bottomLabelConfig = bottomLabelConfig
        self.accessoryViewContext = accessoryViewContext
        self.formatter = formatter
        self.filter = filter
        self.validator = validator
        self.maxCharacterCount = maxCharacterCount
        self.customKeyboard = customKeyboard
    }
}

private class InputTextField: UITextField {
    var customInputViewController: UIInputViewController?
    
    override var inputViewController: UIInputViewController? {
        return customInputViewController
    }
}

private struct UIKitTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String?
    var keyboardType: UIKeyboardType
    var customKeyboard: UIInputViewController
    
    func makeUIView(context: Context) -> InputTextField {
        let textField = InputTextField()
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
    
    func updateUIView(_ uiView: InputTextField, context: Context) {
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
        var parent: UIKitTextField
        
        init(_ parent: UIKitTextField) {
            self.parent = parent
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}
