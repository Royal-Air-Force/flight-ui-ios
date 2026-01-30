import SwiftUI

// MARK: - Input Field

/// A themed text input field with support for labels, placeholders,
/// filtering, formatting, and alerting states.
///
public struct InputField: View {
    @Environment(\.theme) var theme
    @Environment(\.isEnabled) private var isEnabled
    @FocusState var isFocused: Bool

    @Binding var text: String
    let placeholder: String?
    let topLabel: String?
    let topLabelSpacer: Bool
    let bottomLabelConfig: BottomLabelConfig
    let formatter: (@Sendable (String) -> String)?
    let filter: RegexFilter?
    let maxCharacterCount: Int?

    public init(
        text: Binding<String>,
        placeholder: String? = nil,
        topLabel: String? = nil,
        topLabelSpacer: Bool = false,
        bottomLabelConfig: BottomLabelConfig = .init(isVisible: false),
        formatter: (@Sendable (String) -> String)? = nil,
        filter: RegexFilter? = nil,
        maxCharacterCount: Int? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.topLabel = topLabel
        self.topLabelSpacer = topLabelSpacer
        self.bottomLabelConfig = bottomLabelConfig
        self.formatter = formatter
        self.filter = filter
        self.maxCharacterCount = maxCharacterCount
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.grid0_5x) {
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
                .fontStyle(theme.typography.subhead)
        } else if topLabelSpacer {
            Text("-")
                .foregroundColor(theme.color.surfaceHigh.opacity(0))
                .fontStyle(theme.typography.subhead)
        }
    }

    @ViewBuilder
    private func buildTextField() -> some View {
        if let placeholderText = placeholder {
            TextField(text: $text) {
                Text(placeholderText)
                    .foregroundColor(
                        theme.color.primary.opacity(
                            isEnabled ? FieldDefaults.hintOpacity : FieldDefaults.disabledOpacity
                        )
                    )
            }
            .focused($isFocused)
            .onChange(of: text) { _, newValue in
                applyFilters(newValue)
            }
            .onChange(of: isFocused) { _, newFocus in
                if !newFocus, let format = formatter {
                    text = format(text)
                }
            }
        } else {
            TextField("", text: $text)
                .focused($isFocused)
                .onChange(of: text) { _, newValue in
                    applyFilters(newValue)
                }
                .onChange(of: isFocused) { _, newFocus in
                    if !newFocus, let format = formatter {
                        text = format(text)
                    }
                }
        }
    }

    private func applyFilters(_ newValue: String) {
        var modified = newValue

        // Apply regex filter
        if let regex = filter?.regex {
            let replaced = modified.replacingOccurrences(
                of: regex,
                with: "",
                options: .regularExpression
            )
            if replaced != modified {
                modified = replaced
            }
        }

        // Apply character limit
        if let maxCount = maxCharacterCount, modified.count > maxCount {
            modified = String(modified.prefix(maxCount))
        }

        // Only update if changed (prevents infinite loop)
        if modified != text {
            text = modified
        }
    }
}

// MARK: - InputField with Number Formatting

extension InputField {
    /// Creates an InputField configured for decimal number input.
    ///
    /// - Parameters:
    ///   - value: Binding to the text value
    ///   - placeholder: Placeholder text
    ///   - topLabel: Label above the field
    ///   - maxInteger: Maximum integer digits
    ///   - fractionDigits: Number of decimal places
    ///   - maxCharacterCount: Maximum total characters
    ///
    public static func decimal(
        value: Binding<String>,
        placeholder: String? = nil,
        topLabel: String? = nil,
        topLabelSpacer: Bool = false,
        bottomLabelConfig: BottomLabelConfig = .init(isVisible: false),
        maxInteger: Int = 10,
        fractionDigits: Int = 2,
        maxCharacterCount: Int? = nil
    ) -> InputField {
        InputField(
            text: value,
            placeholder: placeholder,
            topLabel: topLabel,
            topLabelSpacer: topLabelSpacer,
            bottomLabelConfig: bottomLabelConfig,
            formatter: NumberFormatting.decimalFormatter(
                maxInteger: maxInteger,
                fractionDigits: fractionDigits
            ),
            filter: .doubleOnly,
            maxCharacterCount: maxCharacterCount
        )
    }

    /// Creates an InputField configured for integer input.

    public static func integer(
        value: Binding<String>,
        placeholder: String? = nil,
        topLabel: String? = nil,
        topLabelSpacer: Bool = false,
        bottomLabelConfig: BottomLabelConfig = .init(isVisible: false),
        minDigits: Int = 1,
        maxDigits: Int = 10,
        maxCharacterCount: Int? = nil
    ) -> InputField {
        InputField(
            text: value,
            placeholder: placeholder,
            topLabel: topLabel,
            topLabelSpacer: topLabelSpacer,
            bottomLabelConfig: bottomLabelConfig,
            formatter: NumberFormatting.integerFormatter(
                minDigits: minDigits,
                maxDigits: maxDigits
            ),
            filter: .integerOnly,
            maxCharacterCount: maxCharacterCount ?? maxDigits
        )
    }
}
