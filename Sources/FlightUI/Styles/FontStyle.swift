import SwiftUI

/// Provides theme based customisation to Font views with the use of a view modifier
/// Extensions allow this to be implemented with Text("").fontStyle(style)
///
/// Note: Line spacing is caluclated from design tools as line height - font size
/// Note: Character spacing set to 0 uses the default value from the Font
public class FontStyle {
    
    private var id: UUID
    public var font: Font
    public var weight: Font.Weight
    public var design: Font.Design
    public var italic: Bool
    public var lineSpacing: CGFloat
    public var charSpacing: CGFloat
    public var foregroundColor: Color?
    
    public init(font: Font,
                weight: Font.Weight = .regular,
                design: Font.Design = .default,
                italic: Bool = false,
                lineSpacing: CGFloat,
                charSpacing: CGFloat = 0,
                foregroundColor: Color? = nil
    ) {
        self.id = UUID()
        self.font = font
        self.weight = weight
        self.design = design
        self.italic = italic
        self.lineSpacing = lineSpacing
        self.charSpacing = charSpacing
        self.foregroundColor = foregroundColor
    }
}

struct FontStyleModifier : ViewModifier {
    @EnvironmentObject var theme: Theme
    
    let style: FontStyle
    
    init(style: FontStyle) {
        self.style = style
    }
    
    func body(content: Content) -> some View {
        content
            .font(style.font
                .weight(style.weight)
                .italic(style.italic))
            .fontDesign(style.design)
            .lineSpacing(style.lineSpacing)
            .tracking(style.charSpacing)
            .foregroundColor(style.foregroundColor ?? theme.color.onSurface.default)
    }
    
}

extension Font {
    public func italic(_ value: Bool) -> Font {
        return value ? self.italic() : self
    }
}

extension View {
    public func fontStyle(_ style: FontStyle) -> some View {
        modifier(FontStyleModifier(style: style))
    }
}
