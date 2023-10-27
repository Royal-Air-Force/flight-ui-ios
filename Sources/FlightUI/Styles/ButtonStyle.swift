import SwiftUI

private class Defaults {
    static let pressedOpacity: CGFloat = 0.6
    static let pressedScale: CGFloat = 0.95
}

// MARK: - Filled Button

public struct FilledButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], theme.padding.grid4x)
            .frame(minHeight: theme.size.large)
            .foregroundColor(getFilledForeground(theme, isEnabled: isEnabled))
            .background(getFilledBackground(theme, isEnabled: isEnabled))
            .fontWeight(.semibold)
            .fontStyle(theme.font.body)
            .clipShape(Capsule())
            .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
            .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
    }
}

public struct FilledIconButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: theme.size.large, minHeight: theme.size.large)
            .foregroundColor(getFilledForeground(theme, isEnabled: isEnabled))
            .background(getFilledBackground(theme, isEnabled: isEnabled))
            .fontWeight(.semibold)
            .fontStyle(theme.font.title3)
            .clipShape(Circle())
            .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
            .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
    }
}

private func getFilledBackground(_ theme: Theme, isEnabled: Bool) -> Color {
    if isEnabled {
        return theme.color.nominal
    } else {
        return theme.color.disabled
    }
}

private func getFilledForeground(_ theme: Theme, isEnabled: Bool) -> Color {
    if isEnabled {
        return theme.color.onCore
    } else {
        return theme.color.onDisabled
    }
}

// MARK: - Tonal Button

public struct TonalButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], theme.padding.grid4x)
            .frame(minHeight: theme.size.large)
            .foregroundColor(getTonalForeground(theme, isEnabled: isEnabled))
            .background(getTonalBackground(theme, isEnabled: isEnabled))
            .fontWeight(.semibold)
            .fontStyle(theme.font.body)
            .clipShape(Capsule())
            .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
            .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
    }
}

public struct TonalIconButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: theme.size.large, minHeight: theme.size.large)
            .foregroundColor(getTonalForeground(theme, isEnabled: isEnabled))
            .background(getTonalBackground(theme, isEnabled: isEnabled))
            .fontWeight(.semibold)
            .fontStyle(theme.font.title3)
            .clipShape(Circle())
            .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
            .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
    }
}

private func getTonalBackground(_ theme: Theme, isEnabled: Bool) -> Color {
    if isEnabled {
        return theme.color.nominal.opacity(0.18)
    } else {
        return theme.color.disabled
    }
}

private func getTonalForeground(_ theme: Theme, isEnabled: Bool) -> Color {
    if isEnabled {
        return theme.color.nominal
    } else {
        return theme.color.onDisabled
    }
}

// MARK: - Outline Button

public struct OutlineButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], theme.padding.grid4x)
            .frame(minHeight: theme.size.large)
            .foregroundColor(getOutlineForeground(theme, isEnabled: isEnabled))
            .fontWeight(.semibold)
            .fontStyle(theme.font.body)
            .clipShape(Capsule())
            .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
            .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
            .overlay(
                Capsule(style: .circular)
                    .strokeBorder(getOutlineForeground(theme, isEnabled: isEnabled), style: StrokeStyle(lineWidth: theme.size.border))
                    .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
                    .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
            )
    }
}

public struct OutlineIconButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: theme.size.large, minHeight: theme.size.large)
            .foregroundColor(getOutlineForeground(theme, isEnabled: isEnabled))
            .fontWeight(.semibold)
            .fontStyle(theme.font.title3)
            .clipShape(Circle())
            .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
            .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
            .overlay(
                Circle()
                    .strokeBorder(getOutlineForeground(theme, isEnabled: isEnabled), style: StrokeStyle(lineWidth: theme.size.border))
                    .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
                    .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
            )
    }
}

private func getOutlineForeground(_ theme: Theme, isEnabled: Bool) -> Color {
    if isEnabled {
        return theme.color.nominal
    } else {
        return theme.color.onDisabled
    }
}

// MARK: - Text Button

public struct TextButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], theme.padding.grid4x)
            .frame(minHeight: theme.size.large)
            .foregroundColor(getTextForeground(theme, isEnabled: isEnabled))
            .fontWeight(.semibold)
            .fontStyle(theme.font.body)
            .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
            .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
    }
}

public struct TextIconButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: theme.size.large, minHeight: theme.size.large)
            .foregroundColor(getTextForeground(theme, isEnabled: isEnabled))
            .fontWeight(.semibold)
            .fontStyle(theme.font.title3)
            .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
            .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
    }
}

private func getTextForeground(_ theme: Theme, isEnabled: Bool) -> Color {
    if isEnabled {
        return theme.color.nominal
    } else {
        return theme.color.onDisabled
    }
}

// MARK: - Core Button
public enum CoreButtonType {
    case advisory, caution, warning
}

public struct CoreButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    private let coreType: CoreButtonType

    public init(coreType: CoreButtonType) {
        self.coreType = coreType
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], theme.padding.grid4x)
            .frame(minHeight: theme.size.large)
            .foregroundColor(getCoreForeground(theme, isEnabled: isEnabled))
            .background(getCoreBackground(theme, coreType: coreType, isEnabled: isEnabled))
            .fontWeight(.semibold)
            .fontStyle(theme.font.body)
            .clipShape(Capsule())
            .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
            .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
    }
}

private func getCoreBackground(_ theme: Theme, coreType: CoreButtonType, isEnabled: Bool) -> Color {
    if isEnabled {
        switch coreType {
        case .advisory:
            return theme.color.primary
        case .caution:
            return theme.color.caution
        case .warning:
            return theme.color.warning
        }
    } else {
        return theme.color.disabled
    }
}

private func getCoreForeground(_ theme: Theme, isEnabled: Bool) -> Color {
    if isEnabled {
        return theme.color.onCore
    } else {
        return theme.color.onDisabled
    }
}
