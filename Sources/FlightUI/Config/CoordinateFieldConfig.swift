import SwiftUI

// MARK: - Coordinate Format

/// The display and entry format for coordinate fields.
///
/// Controls how latitude and longitude values are segmented and presented
/// to the user.
///
public enum CoordinateFormat: String, Sendable, CaseIterable {
    /// A single signed decimal field. Positive values are north/east, negative are south/west.
    /// No hemisphere picker is shown in this mode.
    case signedDecimalDegrees

    /// Hemisphere picker + unsigned decimal degrees (e.g. N 51.47520°).
    /// Equivalent to signed DD but with an explicit N/S or E/W selector.
    case decimalDegrees

    /// Hemisphere picker + integer degrees + decimal minutes.
    /// The default aviation format (e.g. N 51° 28.741').
    case ddm

    /// Hemisphere toggle + integer degrees + integer minutes + decimal seconds.
    /// Used for chart-based entry (e.g. N 51° 28' 44.5").
    case dms

    // MGRS (Military Grid Reference System) is planned for a future version.
}

// MARK: - Cardinal Input Style

/// Controls how the hemisphere selector (N/S or E/W) is displayed in coordinate fields.
///
/// - `button`: A compact square button showing the current direction; tapping cycles to the next.
/// - `segment`: Both directions shown side-by-side as a toggle; the active one is highlighted.
///
public enum CardinalInputStyle: Sendable {
    /// A compact square button that cycles through directions on tap.
    case button
    /// Both directions shown simultaneously; the selected one is highlighted. (Default)
    case segment
}

// MARK: - Coordinate Field Config

/// Configuration options for customizing `CoordinateField`, `LatitudeField`,
/// and `LongitudeField` appearance.
///
/// Use this to override default theme values for specific use cases.
/// All properties are optional — `nil` means "use theme default".
///
public struct CoordinateFieldConfig: Sendable {
    public let fontColor: Color?
    public let fontStyle: FontStyle?
    public let backgroundColor: Color?
    public let cornerRadius: CGFloat?
    public let borderColor: Color?
    /// Controls how the hemisphere selector is displayed. Default is `.segment`.
    public let cardinalStyle: CardinalInputStyle
    /// Number of decimal places for seconds in DMS format. Default is `1` (e.g. `44.5"`).
    public let secondsPrecision: Int
    /// Override colour for the cardinal button/pill highlight. `nil` uses `theme.color.inputOutput`.
    public let cardinalColor: Color?

    public init(
        fontColor: Color? = nil,
        fontStyle: FontStyle? = nil,
        backgroundColor: Color? = nil,
        cornerRadius: CGFloat? = nil,
        borderColor: Color? = nil,
        cardinalStyle: CardinalInputStyle = .segment,
        secondsPrecision: Int = 1,
        cardinalColor: Color? = nil
    ) {
        self.fontColor = fontColor
        self.fontStyle = fontStyle
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.cardinalStyle = cardinalStyle
        self.secondsPrecision = secondsPrecision
        self.cardinalColor = cardinalColor
    }
}

// MARK: - CoordinateFieldConfig Factory

extension CoordinateFieldConfig {
    /// Default configuration with no overrides (uses theme values)
    public static var standard: CoordinateFieldConfig {
        CoordinateFieldConfig()
    }

    /// Configuration for high-contrast scenarios
    public static func highContrast(theme: ThemeData) -> CoordinateFieldConfig {
        CoordinateFieldConfig(
            fontColor: theme.color.inputOutput,
            backgroundColor: theme.color.surfaceLow,
            borderColor: theme.color.primary
        )
    }
}
