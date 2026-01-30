import SwiftUI

// MARK: - Input Alerting State

/// Represents the visual state of input and menu fields.
///
/// These states map to cockpit display standards for situational awareness:
/// - `default`: Normal input state
/// - `advisory`: Read-only/calculated output (uses primary color border)
/// - `nominal`: Positive/confirmed state (green)
/// - `caution`: Attention required (yellow/amber)
/// - `warning`: Critical/error state (red)
public enum InputAlertingState: Sendable {
    case `default`
    case advisory
    case nominal
    case caution
    case warning
}

// MARK: - Field Defaults

/// Shared default values for InputField and MenuField styling.
///
/// These values are based on Material Design opacity guidelines adapted
/// for cockpit visibility requirements.
internal enum FieldDefaults {
    /// Opacity applied to disabled fields (38% per Material guidelines)
    static let disabledOpacity: CGFloat = 0.38

    /// Background opacity for state-colored fields (subtle tint)
    static let stateBackgroundOpacity: CGFloat = 0.08

    /// Opacity for placeholder/hint text
    static let hintOpacity: CGFloat = 0.54
}

// MARK: - Input Field Config

/// Configuration options for customizing InputField appearance.
///
/// Use this to override default theme values for specific use cases.
/// All properties are optional - `nil` means "use theme default".
///
public struct InputFieldConfig: Sendable {
    public let fontColor: Color?
    public let fontStyle: FontStyle?
    public let backgroundColor: Color?
    public let cornerRadius: CGFloat?
    public let borderColor: Color?

    public init(
        fontColor: Color? = nil,
        fontStyle: FontStyle? = nil,
        backgroundColor: Color? = nil,
        cornerRadius: CGFloat? = nil,
        borderColor: Color? = nil
    ) {
        self.fontColor = fontColor
        self.fontStyle = fontStyle
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
    }
}

// MARK: - InputFieldConfig Factory

extension InputFieldConfig {
    /// Default configuration with no overrides (uses theme values)
    public static var standard: InputFieldConfig {
        InputFieldConfig()
    }

    /// Configuration for high-contrast scenarios
    public static func highContrast(theme: ThemeData) -> InputFieldConfig {
        InputFieldConfig(
            fontColor: theme.color.inputOutput,
            backgroundColor: theme.color.surfaceLow,
            borderColor: theme.color.primary
        )
    }
}

// MARK: - Menu Field Config

/// Configuration options for customizing MenuField appearance.
///
/// Use this to override default theme values for specific use cases.
/// All properties are optional - `nil` means "use theme default".
public struct MenuFieldConfig: Sendable {
    public let fontColor: Color?
    public let fontStyle: FontStyle?
    public let backgroundColor: Color?
    public let cornerRadius: CGFloat?
    public let borderColor: Color?

    public init(
        fontColor: Color? = nil,
        fontStyle: FontStyle? = nil,
        backgroundColor: Color? = nil,
        cornerRadius: CGFloat? = nil,
        borderColor: Color? = nil
    ) {
        self.fontColor = fontColor
        self.fontStyle = fontStyle
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
    }
}

// MARK: - MenuFieldConfig Factory

extension MenuFieldConfig {
    /// Default configuration with no overrides (uses theme values)
    public static var standard: MenuFieldConfig {
        MenuFieldConfig()
    }

    /// Configuration for high-contrast scenarios
    public static func highContrast(theme: ThemeData) -> MenuFieldConfig {
        MenuFieldConfig(
            fontColor: theme.color.inputOutput,
            backgroundColor: theme.color.surfaceLow,
            borderColor: theme.color.primary
        )
    }
}
