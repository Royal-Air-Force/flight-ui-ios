import SwiftUI

public extension CardStyle {
    static var elevated: CardStyle {
        return CardStyle(shadow: CardShadow(), backgroundColor: nil, showBorder: false, cardRadius: nil)
    }
    
    static var outline: CardStyle {
        return CardStyle(shadow: nil, backgroundColor: .flightTransparent, showBorder: true, cardRadius: nil)
    }
    
    static var filled: CardStyle {
        return CardStyle(shadow: nil, backgroundColor: nil, showBorder: false, cardRadius: nil)
    }
}
