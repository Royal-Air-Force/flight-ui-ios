//
//  ThemeSize.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

public class ThemeSize {
    @Published public var divider: CGFloat
    @Published public var border: CGFloat

    @Published public var iconSmall: CGFloat
    @Published public var iconMedium: CGFloat
    @Published public var iconLarge: CGFloat

    @Published public var small: CGFloat
    @Published public var medium: CGFloat
    @Published public var large: CGFloat
    @Published public var xLarge: CGFloat
    @Published public var xxLarge: CGFloat
    @Published public var xxxLarge: CGFloat

    public init(divider: CGFloat = 1,
                border: CGFloat = 4,
                iconSmall: CGFloat = 16,
                iconMedium: CGFloat = 24,
                iconLarge: CGFloat = 32,
                small: CGFloat = 40,
                medium: CGFloat = 48,
                large: CGFloat = 56,
                xLarge: CGFloat = 64,
                xxLarge: CGFloat = 72,
                xxxLarge: CGFloat = 80
    ) {
        self.divider = divider
        self.border = border

        self.iconSmall = iconSmall
        self.iconMedium = iconMedium
        self.iconLarge = iconLarge

        self.small = small
        self.medium = medium
        self.large = large
        self.xLarge = xLarge
        self.xxLarge = xxLarge
        self.xxxLarge = xxxLarge
    }
}
