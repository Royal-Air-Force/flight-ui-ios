//
//  CardStyle+Exensions.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

public extension CardStyle {
    static var elevated: CardStyle {
        return CardStyle(shadow: CardShadow(), backgroundColor: nil, showBorder: false, cardRadius: nil, cardPadding: 0)
    }

    static var outline: CardStyle {
        return CardStyle(shadow: nil, backgroundColor: .flightTransparent, showBorder: true, cardRadius: nil, cardPadding: 0)
    }

    static var filled: CardStyle {
        return CardStyle(shadow: nil, backgroundColor: nil, showBorder: false, cardRadius: nil, cardPadding: 0)
    }
}
