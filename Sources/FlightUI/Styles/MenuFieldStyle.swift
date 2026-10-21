import SwiftUI

// MARK: - Menu Field Style

public struct MenuFieldStyle: Sendable {
    public let state: InputAlertingState
    public let config: MenuFieldConfig

    public init(
        _ state: InputAlertingState,
        config: MenuFieldConfig = .standard
    ) {
        self.state = state
        self.config = config
    }

    // MARK: - Style Calculations (take ThemeData, not Theme)

    public func getFontColor(_ theme: ThemeData, isPlaceholder: Bool, isEnabled: Bool) -> Color {
        if isPlaceholder {
            return theme.color.primary.opacity(FieldDefaults.hintOpacity)
        } else if let overrideColor = config.fontColor {
            return overrideColor.opacity(isEnabled ? 1 : FieldDefaults.disabledOpacity)
        } else {
            return theme.color.inputOutput.opacity(isEnabled ? 1 : FieldDefaults.disabledOpacity)
        }
    }

    public func getFieldBackgroundColor(_ theme: ThemeData, isEnabled: Bool) -> Color {
        if !isEnabled {
            return theme.color.surfaceHigh.opacity(FieldDefaults.disabledOpacity)
        }
        if let overrideColor = config.backgroundColor {
            return overrideColor
        }
        switch state {
        case .nominal:
            return theme.color.nominal.opacity(FieldDefaults.stateBackgroundOpacity)
        case .caution:
            return theme.color.caution.opacity(FieldDefaults.stateBackgroundOpacity)
        case .warning:
            return theme.color.warning.opacity(FieldDefaults.stateBackgroundOpacity)
        default:
            return theme.color.surfaceHigh
        }
    }

    public func getCornerRadius(_ theme: ThemeData) -> CGFloat {
        config.cornerRadius ?? theme.radius.medium
    }

    public func getFieldBorderColor(_ theme: ThemeData, isEnabled: Bool) -> Color {
        if let overrideColor = config.borderColor {
            return overrideColor
        }
        switch state {
        case .nominal:
            return theme.color.nominal.opacity(isEnabled ? 1 : FieldDefaults.disabledOpacity)
        case .caution:
            return theme.color.caution.opacity(isEnabled ? 1 : FieldDefaults.disabledOpacity)
        case .warning:
            return theme.color.warning.opacity(isEnabled ? 1 : FieldDefaults.disabledOpacity)
        default:
            return theme.color.surfaceHigh
        }
    }

    public func getFieldBorderSize(_ theme: ThemeData) -> CGFloat {
        switch state {
        case .nominal, .caution, .warning:
            return theme.size.border
        default:
            return 0
        }
    }
}

// MARK: - MenuFieldStyle Factories

extension MenuFieldStyle {
    public static var `default`: MenuFieldStyle {
        MenuFieldStyle(.default)
    }

    public static var nominal: MenuFieldStyle {
        MenuFieldStyle(.nominal)
    }

    public static var caution: MenuFieldStyle {
        MenuFieldStyle(.caution)
    }

    public static var warning: MenuFieldStyle {
        MenuFieldStyle(.warning)
    }
}

// MARK: - Environment Key

private struct MenuFieldStyleEnvironmentKey: EnvironmentKey {
    static let defaultValue: MenuFieldStyle = .default
}

extension EnvironmentValues {
    public var menuFieldStyle: MenuFieldStyle {
        get { self[MenuFieldStyleEnvironmentKey.self] }
        set { self[MenuFieldStyleEnvironmentKey.self] = newValue }
    }
}

// MARK: - View Extension

extension View {
    public func menuFieldStyle(_ style: MenuFieldStyle) -> some View {
        environment(\.menuFieldStyle, style)
    }
}
