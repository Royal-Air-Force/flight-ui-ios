import SwiftUI

// MARK: - Immutable Cards Data

/// Immutable, Sendable card style configuration for a theme.
public struct ThemeCardsData: Sendable {
    public let elevated: CardStyle
    public let filled: CardStyle
    public let outline: CardStyle

    public init(
        elevated: CardStyle,
        filled: CardStyle,
        outline: CardStyle
    ) {
        self.elevated = elevated
        self.filled = filled
        self.outline = outline
    }
}

// MARK: - Cards Data Factories

extension ThemeCardsData {
    /// Standard card styles
    public static var standard: ThemeCardsData {
        ThemeCardsData(
            elevated: .elevated,
            filled: .filled,
            outline: .outline
        )
    }
}
