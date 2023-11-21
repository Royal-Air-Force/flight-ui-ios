import SwiftUI

public struct MenuFieldStyle {
    var state: InputAlertingState
    var config: MenuFieldConfig

    public init(state: InputAlertingState, config: MenuFieldConfig = MenuFieldConfig()) {
        self.state = state
        self.config = config
    }

    func getFontColor(_ theme: Theme, isPlaceholder: Bool, isEnabled: Bool) -> Color {
        if isPlaceholder {
            return theme.color.primary.opacity(MenuFieldDefaults.hintOpacity)
        } else if let overrideColor = config.fontColor {
            return overrideColor.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        } else {
            return theme.color.inputOutput.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        }
    }

    func getFieldBackgroundColor(_ theme: Theme, isEnabled: Bool) -> Color {
        if !isEnabled {
            return theme.color.surfaceHigh.opacity(MenuFieldDefaults.disabledOpacity)
        }

        if let overrideColor = config.backgroundColor {
            return overrideColor
        }

        switch state {
        case .nominal:
            return theme.color.nominal.opacity(MenuFieldDefaults.stateBackgroundOpacity)
        case .caution:
            return theme.color.caution.opacity(MenuFieldDefaults.stateBackgroundOpacity)
        case .warning:
            return theme.color.warning.opacity(MenuFieldDefaults.stateBackgroundOpacity)
        default:
            return theme.color.surfaceHigh
        }
    }

    func getCornerRadius(_ theme: Theme) -> CGFloat {
        if let overrideRadius = config.cornerRadius {
            return overrideRadius
        }
        return theme.radius.medium
    }

    func getFieldBorderColor(_ theme: Theme, isEnabled: Bool) -> Color {
        if let overrideColor = config.borderColor {
            return overrideColor
        }

        switch state {
        case .nominal:
            return theme.color.nominal.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        case .caution:
            return theme.color.caution.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        case .warning:
            return theme.color.warning.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        default:
            return theme.color.surfaceHigh
        }
    }

    func getFieldBorderSize(_ theme: Theme) -> CGFloat {
        switch state {
        case .nominal, .caution, .warning:
            return theme.size.border
        default:
            return 0
        }
    }
}

public struct MenuFieldStyleEnvironmentKey: EnvironmentKey {
    public static var defaultValue: MenuFieldStyle = .init(
        state: .default, config: .init()
    )
}

extension EnvironmentValues {
    var menuFieldStyle: MenuFieldStyle {
        get { self[MenuFieldStyleEnvironmentKey.self] }
        set { self[MenuFieldStyleEnvironmentKey.self] = newValue }
    }
}

extension View {
    public func menuFieldStyle(_ style: MenuFieldStyle) -> some View {
        environment(\.menuFieldStyle, style)
    }
}
