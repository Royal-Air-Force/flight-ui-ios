//
//  ThemeCards.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

public class ThemeCards {
    @Published public var elevated: CardStyle
    @Published public var filled: CardStyle
    @Published public var outline: CardStyle

    public init(elevated: CardStyle = .elevated,
                filled: CardStyle = .filled,
                outline: CardStyle = .outline) {
        self.elevated = elevated
        self.filled = filled
        self.outline = outline
    }

}
