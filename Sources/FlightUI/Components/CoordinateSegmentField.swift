import SwiftUI

// MARK: - Coordinate Segment Field

/// An internal single-segment input view that renders a number field
/// with the unit symbol (°, ʹ, ʺ) embedded inside the container.
///
/// Symbols are placed inside the field background so they are never clipped
/// on narrow screens. The field always takes its natural (fixed) horizontal
/// size based on the placeholder text.
///
struct CoordinateSegmentField: View {
    @Environment(\.theme) var theme
    @Environment(\.isEnabled) var isEnabled
    @FocusState private var isFocused: Bool

    @Binding var text: String
    let placeholder: String
    let suffix: String
    let filter: RegexFilter
    let maxCharacterCount: Int
    let state: InputAlertingState
    let config: InputFieldConfig
    /// When set, overrides the default fixed-size behaviour and pins the field to exactly this width.
    /// Used by `CoordinateField` to equalize the degrees column across lat and lon rows.
    let minWidth: CGFloat?

    init(_ text: Binding<String>, placeholder: String, suffix: String,
         filter: RegexFilter, maxChar: Int, state: InputAlertingState,
         config: InputFieldConfig, minWidth: CGFloat? = nil) {
        self._text = text
        self.placeholder = placeholder
        self.suffix = suffix
        self.filter = filter
        self.maxCharacterCount = maxChar
        self.state = state
        self.config = config
        self.minWidth = minWidth
    }

    var body: some View {
        HStack(spacing: theme.spacing.grid0_5x) {
            TextField(text: $text) {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
            }
            .focused($isFocused)
            .multilineTextAlignment(.trailing)
            .foregroundColor(fontColor)
            .fontStyle(config.fontStyle ?? theme.typography.bodyBold)
            .onChange(of: text) { _, newValue in applyFilter(newValue) }
            Text(suffix)
                .foregroundColor(theme.color.secondary)
                .fontStyle(theme.typography.body)
        }
        .padding(.horizontal, theme.spacing.grid1x)
        .frame(minWidth: minWidth, maxWidth: minWidth, minHeight: theme.size.large)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .strokeBorder(borderColor, lineWidth: borderSize)
        }
        .fixedSize(horizontal: minWidth == nil, vertical: false)
        .disabled(state == .advisory)
    }

    // MARK: - Filter

    private func applyFilter(_ newValue: String) {
        var modified = newValue
        let replaced = modified.replacingOccurrences(of: filter.regex, with: "", options: .regularExpression)
        if replaced != modified { modified = replaced }
        if modified.count > maxCharacterCount { modified = String(modified.prefix(maxCharacterCount)) }
        if modified != text { text = modified }
    }

    // MARK: - Colours

    private var placeholderColor: Color {
        theme.color.primary.opacity(isEnabled ? FieldDefaults.hintOpacity : FieldDefaults.disabledOpacity)
    }

    private var fontColor: Color {
        if let override = config.fontColor { return override }
        switch state {
        case .advisory: return theme.color.primary
        default:        return theme.color.inputOutput.opacity(isEnabled ? 1 : FieldDefaults.disabledOpacity)
        }
    }

    private var backgroundColor: Color {
        if !isEnabled { return theme.color.surfaceHigh.opacity(FieldDefaults.disabledOpacity) }
        if let override = config.backgroundColor { return override }
        switch state {
        case .default, .advisory: return theme.color.surfaceHigh
        case .nominal:            return theme.color.nominal.opacity(FieldDefaults.stateBackgroundOpacity)
        case .caution:            return theme.color.caution.opacity(FieldDefaults.stateBackgroundOpacity)
        case .warning:            return theme.color.warning.opacity(FieldDefaults.stateBackgroundOpacity)
        }
    }

    private var cornerRadius: CGFloat { config.cornerRadius ?? theme.radius.medium }

    private var borderColor: Color {
        if let override = config.borderColor { return override }
        switch state {
        case .default:  return theme.color.surfaceHigh
        case .advisory: return theme.color.primary.opacity(isEnabled ? 1 : FieldDefaults.disabledOpacity)
        case .nominal:  return theme.color.nominal.opacity(isEnabled ? 1 : FieldDefaults.disabledOpacity)
        case .caution:  return theme.color.caution.opacity(isEnabled ? 1 : FieldDefaults.disabledOpacity)
        case .warning:  return theme.color.warning.opacity(isEnabled ? 1 : FieldDefaults.disabledOpacity)
        }
    }

    private var borderSize: CGFloat {
        switch state {
        case .nominal, .caution, .warning: return theme.size.border
        default:                           return 0
        }
    }
}
