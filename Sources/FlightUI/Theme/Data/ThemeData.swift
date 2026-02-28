import SwiftUI

// MARK: - Unified Theme Data

/// Immutable, Sendable complete theme configuration.
/// This is the core data structure that can be safely passed across isolation boundaries.
public struct ThemeData: Sendable {
    public let baseScheme: ColorScheme
    public let color: ThemeColorData
    public let spacing: ThemeSpacingData
    public let size: ThemeSizeData
    public let radius: ThemeRadiusData
    public let typography: ThemeTypographyData
    public let cards: ThemeCardsData

    public init(
        baseScheme: ColorScheme,
        color: ThemeColorData,
        spacing: ThemeSpacingData,
        size: ThemeSizeData,
        radius: ThemeRadiusData,
        typography: ThemeTypographyData,
        cards: ThemeCardsData = .standard
    ) {
        self.baseScheme = baseScheme
        self.color = color
        self.spacing = spacing
        self.size = size
        self.radius = radius
        self.typography = typography
        self.cards = cards
    }
}

// MARK: - ThemeData Factories

extension ThemeData {
    /// Dark theme configuration
    public static var dark: ThemeData {
        ThemeData(
            baseScheme: .dark,
            color: .dark,
            spacing: .standard,
            size: .standard,
            radius: .standard,
            typography: .standard
        )
    }

    /// Light theme configuration
    public static var light: ThemeData {
        ThemeData(
            baseScheme: .light,
            color: .light,
            spacing: .standard,
            size: .standard,
            radius: .standard,
            typography: .standard
        )
    }
}

// MARK: - ThemeData Transformations

extension ThemeData {
    /// Returns a new theme with different colors
    public func withColors(_ colors: ThemeColorData) -> ThemeData {
        ThemeData(
            baseScheme: baseScheme,
            color: colors,
            spacing: spacing,
            size: size,
            radius: radius,
            typography: typography,
            cards: cards
        )
    }

    /// Returns a new theme with different spacing
    public func withSpacing(_ spacing: ThemeSpacingData) -> ThemeData {
        ThemeData(
            baseScheme: baseScheme,
            color: color,
            spacing: spacing,
            size: size,
            radius: radius,
            typography: typography,
            cards: cards
        )
    }

    /// Returns a new theme with different sizes
    public func withSize(_ size: ThemeSizeData) -> ThemeData {
        ThemeData(
            baseScheme: baseScheme,
            color: color,
            spacing: spacing,
            size: size,
            radius: radius,
            typography: typography,
            cards: cards
        )
    }

    /// Returns a new theme with different radii
    public func withRadius(_ radius: ThemeRadiusData) -> ThemeData {
        ThemeData(
            baseScheme: baseScheme,
            color: color,
            spacing: spacing,
            size: size,
            radius: radius,
            typography: typography,
            cards: cards
        )
    }

    /// Returns a new theme with different typography
    public func withTypography(_ typography: ThemeTypographyData) -> ThemeData {
        ThemeData(
            baseScheme: baseScheme,
            color: color,
            spacing: spacing,
            size: size,
            radius: radius,
            typography: typography,
            cards: cards
        )
    }

    /// Returns a new theme scaled by the given factor (affects spacing, size, radius, typography)
    public func scaled(by factor: CGFloat) -> ThemeData {
        ThemeData(
            baseScheme: baseScheme,
            color: color,
            spacing: spacing.scaled(by: factor),
            size: size.scaled(by: factor),
            radius: radius.scaled(by: factor),
            typography: typography.scaled(by: factor),
            cards: cards
        )
    }

    /// Returns a new theme with the opposite color scheme
    public var inverted: ThemeData {
        switch baseScheme {
        case .dark:
            return ThemeData(
                baseScheme: .light,
                color: .light,
                spacing: spacing,
                size: size,
                radius: radius,
                typography: typography,
                cards: cards
            )
        case .light:
            return ThemeData(
                baseScheme: .dark,
                color: .dark,
                spacing: spacing,
                size: size,
                radius: radius,
                typography: typography,
                cards: cards
            )
        @unknown default:
            return self
        }
    }
}
