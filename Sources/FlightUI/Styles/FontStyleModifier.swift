import SwiftUI

// MARK: - FontStyle View Modifier

struct FontStyleModifier: ViewModifier {
    @Environment(\.theme) var theme
    @Environment(\.sizeCategory) var sizeCategory

    let style: FontStyle

    init(style: FontStyle) {
        self.style = style
    }

    func body(content: Content) -> some View {
        content
            .font(.system(
                size: UIFontMetrics.default.scaledValue(for: style.size),
                weight: style.weight,
                design: style.design))
            .italic(style.italic)
            .lineSpacing(style.lineSpacing)
            .tracking(style.charSpacing)
            .foregroundColor(style.foregroundColor ?? theme.color.primary)
    }
}

// MARK: - Font Extension

extension Font {
    /// Conditionally applies italic style
    public func italic(_ value: Bool) -> Font {
        value ? self.italic() : self
    }
}

// MARK: - View Extension

extension View {
    /// Applies a FontStyle to this view
    public func fontStyle(_ style: FontStyle) -> some View {
        modifier(FontStyleModifier(style: style))
    }
}
