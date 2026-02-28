import SwiftUI

// MARK: - Immutable Spacing Data

/// Immutable, Sendable spacing/padding configuration for a theme.
public struct ThemeSpacingData: Sendable {
    public let grid0_5x: CGFloat
    public let grid1x: CGFloat
    public let grid1_5x: CGFloat
    public let grid2x: CGFloat
    public let grid2_5x: CGFloat
    public let grid3x: CGFloat
    public let grid4x: CGFloat
    public let grid5x: CGFloat
    public let grid6x: CGFloat
    public let grid7x: CGFloat
    public let grid8x: CGFloat
    public let grid9x: CGFloat
    public let grid10x: CGFloat

    public init(
        grid0_5x: CGFloat,
        grid1x: CGFloat,
        grid1_5x: CGFloat,
        grid2x: CGFloat,
        grid2_5x: CGFloat,
        grid3x: CGFloat,
        grid4x: CGFloat,
        grid5x: CGFloat,
        grid6x: CGFloat,
        grid7x: CGFloat,
        grid8x: CGFloat,
        grid9x: CGFloat,
        grid10x: CGFloat
    ) {
        self.grid0_5x = grid0_5x
        self.grid1x = grid1x
        self.grid1_5x = grid1_5x
        self.grid2x = grid2x
        self.grid2_5x = grid2_5x
        self.grid3x = grid3x
        self.grid4x = grid4x
        self.grid5x = grid5x
        self.grid6x = grid6x
        self.grid7x = grid7x
        self.grid8x = grid8x
        self.grid9x = grid9x
        self.grid10x = grid10x
    }
}

// MARK: - Spacing Data Factories

extension ThemeSpacingData {
    /// Standard 8pt grid spacing
    public static var standard: ThemeSpacingData {
        ThemeSpacingData(
            grid0_5x: 4,
            grid1x: 8,
            grid1_5x: 12,
            grid2x: 16,
            grid2_5x: 20,
            grid3x: 24,
            grid4x: 32,
            grid5x: 40,
            grid6x: 48,
            grid7x: 56,
            grid8x: 64,
            grid9x: 72,
            grid10x: 80
        )
    }

    /// Compact spacing for dense UIs
    public static var compact: ThemeSpacingData {
        ThemeSpacingData(
            grid0_5x: 2,
            grid1x: 4,
            grid1_5x: 6,
            grid2x: 8,
            grid2_5x: 10,
            grid3x: 12,
            grid4x: 16,
            grid5x: 20,
            grid6x: 24,
            grid7x: 28,
            grid8x: 32,
            grid9x: 36,
            grid10x: 40
        )
    }

    /// Returns a new spacing configuration scaled by the given factor
    public func scaled(by factor: CGFloat) -> ThemeSpacingData {
        ThemeSpacingData(
            grid0_5x: grid0_5x * factor,
            grid1x: grid1x * factor,
            grid1_5x: grid1_5x * factor,
            grid2x: grid2x * factor,
            grid2_5x: grid2_5x * factor,
            grid3x: grid3x * factor,
            grid4x: grid4x * factor,
            grid5x: grid5x * factor,
            grid6x: grid6x * factor,
            grid7x: grid7x * factor,
            grid8x: grid8x * factor,
            grid9x: grid9x * factor,
            grid10x: grid10x * factor
        )
    }
}
