import SwiftUI

public class CardStyle {
    
    private var id: UUID
    public var shadow: Bool
    
    public init(shadow: Bool) {
        self.id = UUID()
        self.shadow = shadow
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
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.white)
            content
        }
    }
    
    
}

extension View {
    public func cardStyle(_ style: CardStyle) -> some View {
        modifier(CardStyleModifier(style: style))
    }
}
