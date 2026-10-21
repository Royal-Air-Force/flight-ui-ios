import SwiftUI

// MARK: - Immutable Size Data

/// Immutable, Sendable size configuration for a theme.
public struct ThemeSizeData: Sendable {
    public let divider: CGFloat
    public let border: CGFloat

    public let iconSmall: CGFloat
    public let iconMedium: CGFloat
    public let iconLarge: CGFloat

    public let small: CGFloat
    public let medium: CGFloat
    public let large: CGFloat
    public let xLarge: CGFloat
    public let xxLarge: CGFloat
    public let xxxLarge: CGFloat

    public init(
        divider: CGFloat,
        border: CGFloat,
        iconSmall: CGFloat,
        iconMedium: CGFloat,
        iconLarge: CGFloat,
        small: CGFloat,
        medium: CGFloat,
        large: CGFloat,
        xLarge: CGFloat,
        xxLarge: CGFloat,
        xxxLarge: CGFloat
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

// MARK: - Size Data Factories

extension ThemeSizeData {
    /// Standard size configuration
    public static var standard: ThemeSizeData {
        ThemeSizeData(
            divider: 1,
            border: 4,
            iconSmall: 16,
            iconMedium: 24,
            iconLarge: 32,
            small: 40,
            medium: 48,
            large: 56,
            xLarge: 64,
            xxLarge: 72,
            xxxLarge: 80
        )
    }

    /// Compact size configuration for dense UIs
    public static var compact: ThemeSizeData {
        ThemeSizeData(
            divider: 1,
            border: 2,
            iconSmall: 12,
            iconMedium: 18,
            iconLarge: 24,
            small: 32,
            medium: 40,
            large: 48,
            xLarge: 56,
            xxLarge: 64,
            xxxLarge: 72
        )
    }

    /// Returns a new size configuration scaled by the given factor
    public func scaled(by factor: CGFloat) -> ThemeSizeData {
        ThemeSizeData(
            divider: divider,
            border: border * factor,
            iconSmall: iconSmall * factor,
            iconMedium: iconMedium * factor,
            iconLarge: iconLarge * factor,
            small: small * factor,
            medium: medium * factor,
            large: large * factor,
            xLarge: xLarge * factor,
            xxLarge: xxLarge * factor,
            xxxLarge: xxxLarge * factor
        )
    }
}
