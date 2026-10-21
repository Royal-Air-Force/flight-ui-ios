import SwiftUI

// MARK: - Immutable Radius Data

/// Immutable, Sendable corner radius configuration for a theme.
public struct ThemeRadiusData: Sendable {
    public let small: CGFloat
    public let medium: CGFloat
    public let large: CGFloat

    public init(
        small: CGFloat,
        medium: CGFloat,
        large: CGFloat
    ) {
        self.small = small
        self.medium = medium
        self.large = large
    }

    /// Calculates the inner radius for nested rounded rectangles
    public func innerSmall(padding: CGFloat) -> CGFloat {
        calculateInnerRadius(outerRadius: small, outerPadding: padding)
    }

    /// Calculates the inner radius for nested rounded rectangles
    public func innerMedium(padding: CGFloat) -> CGFloat {
        calculateInnerRadius(outerRadius: medium, outerPadding: padding)
    }

    /// Calculates the inner radius for nested rounded rectangles
    public func innerLarge(padding: CGFloat) -> CGFloat {
        calculateInnerRadius(outerRadius: large, outerPadding: padding)
    }

    /// Calculates inner radius based on outer radius and padding
    public func calculateInnerRadius(outerRadius: CGFloat, outerPadding: CGFloat) -> CGFloat {
        let radius = outerRadius - (outerPadding / 2)
        return max(radius, 1)
    }
}

// MARK: - Radius Data Factories

extension ThemeRadiusData {
    /// Standard corner radius configuration
    public static var standard: ThemeRadiusData {
        ThemeRadiusData(
            small: 4,
            medium: 8,
            large: 20
        )
    }

    /// Sharp corners configuration
    public static var sharp: ThemeRadiusData {
        ThemeRadiusData(
            small: 2,
            medium: 4,
            large: 8
        )
    }

    /// Rounded configuration
    public static var rounded: ThemeRadiusData {
        ThemeRadiusData(
            small: 8,
            medium: 16,
            large: 32
        )
    }

    /// Returns a new radius configuration scaled by the given factor
    public func scaled(by factor: CGFloat) -> ThemeRadiusData {
        ThemeRadiusData(
            small: small * factor,
            medium: medium * factor,
            large: large * factor
        )
    }
}
