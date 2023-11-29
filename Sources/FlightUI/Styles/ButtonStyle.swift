//
//  ButtonStyle.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

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
            .frame(minHeight: theme.size.medium)
            .foregroundColor(getFilledForeground(theme, isEnabled: isEnabled))
            .background(getFilledBackground(theme, isEnabled: isEnabled))
            .fontStyle(theme.font.bodyBold)
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
            .frame(minWidth: theme.size.medium, minHeight: theme.size.medium)
            .foregroundColor(getFilledForeground(theme, isEnabled: isEnabled))
            .background(getFilledBackground(theme, isEnabled: isEnabled))
            .fontStyle(theme.font.bodyBold)
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
            .frame(minHeight: theme.size.medium)
            .foregroundColor(getTonalForeground(theme, isEnabled: isEnabled))
            .background(getTonalBackground(theme, isEnabled: isEnabled))
            .fontStyle(theme.font.bodyBold)
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
            .frame(minWidth: theme.size.medium, minHeight: theme.size.medium)
            .foregroundColor(getTonalForeground(theme, isEnabled: isEnabled))
            .background(getTonalBackground(theme, isEnabled: isEnabled))
            .fontStyle(theme.font.bodyBold)
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
            .frame(minHeight: theme.size.medium)
            .foregroundColor(getOutlineForeground(theme, isEnabled: isEnabled))
            .fontStyle(theme.font.bodyBold)
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
            .frame(minWidth: theme.size.medium, minHeight: theme.size.medium)
            .foregroundColor(getOutlineForeground(theme, isEnabled: isEnabled))
            .fontStyle(theme.font.bodyBold)
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
            .frame(minHeight: theme.size.medium)
            .foregroundColor(getTextForeground(theme, isEnabled: isEnabled))
            .fontStyle(theme.font.bodyBold)
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
            .frame(minWidth: theme.size.medium, minHeight: theme.size.medium)
            .foregroundColor(getTextForeground(theme, isEnabled: isEnabled))
            .fontStyle(theme.font.bodyBold)
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
            .frame(minHeight: theme.size.medium)
            .foregroundColor(getCoreForeground(theme, isEnabled: isEnabled))
            .background(getCoreBackground(theme, coreType: coreType, isEnabled: isEnabled))
            .fontStyle(theme.font.bodyBold)
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

#if DEBUG

struct FilledButtonStyle_Previews: PreviewProvider {
    static var theme: Theme = Theme(baseScheme: .dark)

    static var previews: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid2x) {
            // Filled Only Text
            Button("Default Filled") {}
                .buttonStyle(.filled)
            Button("Disabled Filled") {}
                .buttonStyle(.filled)
                .disabled(true)

            // Filled Only Icon
            Button {} label: {
                Image(systemName: "plus")
            }.buttonStyle(.filledIcon)
            Button {} label: {
                Image(systemName: "plus")
            }.buttonStyle(.filledIcon)
                .disabled(true)

            // Filled Text Icon
            Button {} label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Default Filled With Icon")
                }
            }.buttonStyle(.filled)
            Button {} label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Disabled Filled With Icon")
                }
            }.buttonStyle(.filled)
                .disabled(true)
        }
        .environmentObject(theme)
        .previewDisplayName("Filled Button Style")
        .preferredColorScheme(theme.baseScheme)
    }
}

struct TonalButtonStyle_Previews: PreviewProvider {
    static var theme: Theme = Theme(baseScheme: .dark)

    static var previews: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid2x) {
            // Tonal Only Text
            Button("Default Tonal") {}
                .buttonStyle(.tonal)
            Button("Disabled Tonal") {}
                .buttonStyle(.tonal)
                .disabled(true)

            // Tonal Only Icon
            Button {} label: {
                Image(systemName: "plus")
            }.buttonStyle(.tonalIcon)
            Button {} label: {
                Image(systemName: "plus")
            }.buttonStyle(.tonalIcon)
                .disabled(true)

            // Tonal Text Icon
            Button {} label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Default Tonal With Icon")
                }
            }.buttonStyle(.tonal)
            Button {} label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Disabled Tonal With Icon")
                }
            }.buttonStyle(.tonal)
                .disabled(true)
        }
        .environmentObject(theme)
        .previewDisplayName("Tonal Button Style")
        .preferredColorScheme(theme.baseScheme)
    }
}

struct OutlineButtonStyle_Previews: PreviewProvider {
    static var theme: Theme = Theme(baseScheme: .dark)

    static var previews: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid2x) {
            // Outline Only Text
            Button("Default Outline") {}
                .buttonStyle(.outline)
            Button("Disabled Outline") {}
                .buttonStyle(.outline)
                .disabled(true)

            // Outline Only Icon
            Button {} label: {
                Image(systemName: "plus")
            }.buttonStyle(.outlineIcon)
            Button {} label: {
                Image(systemName: "plus")
            }.buttonStyle(.outlineIcon)
                .disabled(true)

            // Outline Text Icon
            Button {} label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Default Outline With Icon")
                }
            }.buttonStyle(.outline)
            Button {} label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Disabled Outline With Icon")
                }
            }.buttonStyle(.outline)
                .disabled(true)
        }
        .environmentObject(theme)
        .previewDisplayName("Outline Button Style")
        .preferredColorScheme(theme.baseScheme)
    }
}

struct TextButtonStyle_Previews: PreviewProvider {
    static var theme: Theme = Theme(baseScheme: .dark)

    static var previews: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid2x) {
            // Text Only Text
            Button("Default Text") {}
                .buttonStyle(.text)
            Button("Disabled Text") {}
                .buttonStyle(.text)
                .disabled(true)

            // Text Only Icon
            Button {} label: {
                Image(systemName: "plus")
            }.buttonStyle(.textIcon)
            Button {} label: {
                Image(systemName: "plus")
            }.buttonStyle(.textIcon)
                .disabled(true)

            // Text Text Icon
            Button {} label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Default Text With Icon")
                }
            }.buttonStyle(.text)
            Button {} label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Disabled Text With Icon")
                }
            }.buttonStyle(.text)
                .disabled(true)
        }
        .environmentObject(theme)
        .previewDisplayName("Text Button Style")
        .preferredColorScheme(theme.baseScheme)
    }
}

#endif
