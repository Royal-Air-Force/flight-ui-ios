import SwiftUI

public class FontStyle {
    
    private var id: UUID
    public var font: Font
    public var weight: Font.Weight
    public var design: Font.Design
    public var italic: Bool
    public var lineSpacing: CGFloat
    public var charSpacing: CGFloat
    public var foregroundColor: Color?
    
    public init(font: Font, weight: Font.Weight, design: Font.Design, italic: Bool, lineSpacing: CGFloat, charSpacing: CGFloat, foregroundColor: Color?) {
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
