//
//  InputField.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

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
    var supportLabelConfig: SupportLabelConfig
    var formatter: ((String) -> String)?
    var filter: RegexFilter?

    public init(
        text: Binding<String>,
        placeholder: String? = nil,
        topLabel: String? = nil,
        topLabelSpacer: Bool = false,
        supportLabelConfig: SupportLabelConfig = .init(isVisible: false),
        formatter: ((String) -> String)? = nil,
        filter: RegexFilter? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.topLabel = topLabel
        self.topLabelSpacer = topLabelSpacer
        self.supportLabelConfig = supportLabelConfig
        self.formatter = formatter
        self.filter = filter
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid0_5x) {
            buildTopLabel()
            buildTextField()
            SupportLabel(supportLabelConfig)
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
            .onReceive(Just(text)) { newValue in
                if let regex = filter?.regex {
                    let replaced = newValue.replacingOccurrences(of: regex, with: "", options: .regularExpression)
                    if replaced != newValue {
                        self.text = replaced
                    }
                }
            }
            .focused($isFocused)
            .onChange(of: isFocused) { newFocus in
                if !newFocus, let format = formatter {
                    text = format(text)
                }
            }
        } else {
            TextField("", text: $text)
                .onReceive(Just(text)) { newValue in
                    if let regex = filter?.regex {
                        let replaced = newValue.replacingOccurrences(of: regex, with: "", options: .regularExpression)
                        if replaced != newValue {
                            self.text = replaced
                        }
                    }
                }
                .focused($isFocused)
                .onChange(of: isFocused) { newFocus in
                    if !newFocus, let format = formatter {
                        text = format(text)
                    }
                }
        }
    }
}
