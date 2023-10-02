import SwiftUI

private class Defaults {
    static let shadowRadius: CGFloat = 4
}

public class CardStyle {
    
    private var id: UUID
    public var shadow: CardShadow?
    public var backgroundColor: Color?
    public var showBorder: Bool
    
    public init(shadow: CardShadow?, backgroundColor: Color?, showBorder: Bool) {
        self.id = UUID()
        self.shadow = shadow
        self.backgroundColor = backgroundColor
        self.showBorder = showBorder
    }
}

public struct CardShadow {
    var color: Color
    var radius: CGFloat
    
    init(color: Color = .black.opacity(0.4), radius: CGFloat = Defaults.shadowRadius) {
        self.color = color
        self.radius = radius
    }
}

struct CardStyleModifier: ViewModifier {
    @EnvironmentObject var theme: Theme
    
    let style: CardStyle
    
    init(style: CardStyle) {
        self.style = style
    }
    
    func body(content: Content) -> some View {
        ZStack {
            getBaseCard()
                .ifNotNil(style.shadow, transform: { view, shadow in
                    view.shadow(color: shadow.color, radius: shadow.radius, x: 2, y: 4)
                })
            content
        }
    }
    
    @ViewBuilder
    private func getBaseCard() -> some View {
        if (style.showBorder) {
            RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous)
                .style(
                    withStroke: theme.color.onSurface.default.opacity(0.2),
                    lineWidth: theme.size.border,
                    fill: style.backgroundColor ?? theme.color.surface)
        } else {
            RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous)
                .fill(style.backgroundColor ?? theme.color.surface)
        }
    }
}

extension View {
    public func cardStyle(_ style: CardStyle) -> some View {
        modifier(CardStyleModifier(style: style))
    }
}
