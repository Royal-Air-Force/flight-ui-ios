import SwiftUI

private class Defaults {
    static let pressedOpacity: CGFloat = 0.6
    static let pressedScale: CGFloat = 0.95
}

public struct FilledButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.isFocused) private var isFocused: Bool
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], theme.padding.grid4x)
            .frame(minHeight: theme.size.medium)
            .foregroundColor(theme.color.onNominal.getColorForState(disabled: !isEnabled, focused: isFocused))
            .background(theme.color.nominal.getColorForState(disabled: !isEnabled, focused: isFocused))
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
    @Environment(\.isFocused) private var isFocused: Bool
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: theme.size.medium, minHeight: theme.size.medium)
            .foregroundColor(theme.color.onNominal.getColorForState(disabled: !isEnabled, focused: isFocused))
            .background(theme.color.nominal.getColorForState(disabled: !isEnabled, focused: isFocused))
            .fontWeight(.semibold)
            .fontStyle(theme.font.title3)
            .clipShape(Circle())
            .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
            .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
    }
}

public struct TonalButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.isFocused) private var isFocused: Bool
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], theme.padding.grid4x)
            .frame(minHeight: theme.size.medium)
            .foregroundColor(theme.color.nominal.getColorForState(disabled: !isEnabled, focused: isFocused))
            .background(getTonalBackgroundColor(theme: theme, isEnabled: isEnabled, isFocused: isFocused))
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
    @Environment(\.isFocused) private var isFocused: Bool
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: theme.size.medium, minHeight: theme.size.medium)
            .foregroundColor(theme.color.nominal.getColorForState(disabled: !isEnabled, focused: isFocused))
            .background(getTonalBackgroundColor(theme: theme, isEnabled: isEnabled, isFocused: isFocused))
            .fontWeight(.semibold)
            .fontStyle(theme.font.title3)
            .clipShape(Circle())
            .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
            .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
    }
}

private func getTonalBackgroundColor(theme: Theme, isEnabled: Bool, isFocused: Bool) -> Color {
    if (!isEnabled) {
        return theme.color.onSurface.default.opacity(0.12)
    } else if (isFocused) {
        return theme.color.nominal.default.opacity(0.38)
    } else {
        return theme.color.nominal.default.opacity(0.16)
    }
}

public struct OutlineButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.isFocused) private var isFocused: Bool
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], theme.padding.grid4x)
            .frame(minHeight: theme.size.medium)
            .foregroundColor(theme.color.nominal.getColorForState(disabled: !isEnabled, focused: isFocused))
            .fontWeight(.semibold)
            .fontStyle(theme.font.body)
            .clipShape(Capsule())
            .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
            .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
            .overlay(
                Capsule(style: .circular)
                    .strokeBorder(theme.color.nominal.getColorForState(disabled: !isEnabled, focused: isFocused), style: StrokeStyle(lineWidth: theme.size.border))
                    .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
                    .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
            )
    }
}

public struct OutlineIconButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.isFocused) private var isFocused: Bool
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: theme.size.medium, minHeight: theme.size.medium)
            .foregroundColor(theme.color.nominal.getColorForState(disabled: !isEnabled, focused: isFocused))
            .fontWeight(.semibold)
            .fontStyle(theme.font.title3)
            .clipShape(Circle())
            .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
            .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
            .overlay(
                Circle()
                    .strokeBorder(theme.color.nominal.getColorForState(disabled: !isEnabled, focused: isFocused), style: StrokeStyle(lineWidth: theme.size.border))
                    .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
                    .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
            )
    }
}

public struct TextButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.isFocused) private var isFocused: Bool
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], theme.padding.grid4x)
            .frame(minHeight: theme.size.medium)
            .foregroundColor(theme.color.nominal.getColorForState(disabled: !isEnabled, focused: isFocused))
            .fontWeight(.semibold)
            .fontStyle(theme.font.body)
            .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
            .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
    }
}

public struct TextIconButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.isFocused) private var isFocused: Bool
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: theme.size.medium, minHeight: theme.size.medium)
            .foregroundColor(theme.color.nominal.getColorForState(disabled: !isEnabled, focused: isFocused))
            .fontWeight(.semibold)
            .fontStyle(theme.font.title3)
            .opacity(configuration.isPressed ? Defaults.pressedOpacity : 1.0)
            .scaleEffect(configuration.isPressed ? Defaults.pressedScale : 1.0)
    }
}