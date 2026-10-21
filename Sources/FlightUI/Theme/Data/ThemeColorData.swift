import SwiftUI

// MARK: - Core Immutable Data Structures

/// Immutable, Sendable color configuration for a theme.
public struct ThemeColorData: Sendable {
    // General Colors
    public let background: Color
    public let surfaceLow: Color
    public let surfaceHigh: Color
    public let primary: Color
    public let secondary: Color
    public let disabled: Color
    public let onDisabled: Color

    // Core Colors
    public let inputOutput: Color
    public let nominal: Color
    public let caution: Color
    public let warning: Color
    public let onCore: Color
    public var advisory: Color { nominal }

    // Graphics Colors
    public let graphicsRed: Color
    public let graphicsYellow: Color
    public let graphicsGreen: Color
    public let graphicsMint: Color
    public let graphicsCyan: Color
    public let graphicsBlue: Color
    public let graphicsIndigo: Color
    public let graphicsPurple: Color
    public let graphicsPink: Color

    public init(
        background: Color,
        surfaceLow: Color,
        surfaceHigh: Color,
        primary: Color,
        secondary: Color,
        disabled: Color,
        onDisabled: Color,
        inputOutput: Color,
        nominal: Color,
        caution: Color,
        warning: Color,
        onCore: Color,
        graphicsRed: Color,
        graphicsYellow: Color,
        graphicsGreen: Color,
        graphicsMint: Color,
        graphicsCyan: Color,
        graphicsBlue: Color,
        graphicsIndigo: Color,
        graphicsPurple: Color,
        graphicsPink: Color
    ) {
        self.background = background
        self.surfaceLow = surfaceLow
        self.surfaceHigh = surfaceHigh
        self.primary = primary
        self.secondary = secondary
        self.disabled = disabled
        self.onDisabled = onDisabled
        self.inputOutput = inputOutput
        self.nominal = nominal
        self.caution = caution
        self.warning = warning
        self.onCore = onCore
        self.graphicsRed = graphicsRed
        self.graphicsYellow = graphicsYellow
        self.graphicsGreen = graphicsGreen
        self.graphicsMint = graphicsMint
        self.graphicsCyan = graphicsCyan
        self.graphicsBlue = graphicsBlue
        self.graphicsIndigo = graphicsIndigo
        self.graphicsPurple = graphicsPurple
        self.graphicsPink = graphicsPink
    }
}

// MARK: - Color Data Factories

extension ThemeColorData {
    /// Dark theme color configuration
    public static var dark: ThemeColorData {
        ThemeColorData(
            background: .flightGrey100,
            surfaceLow: .flightGrey200,
            surfaceHigh: .flightGrey300,
            primary: .flightGrey600,
            secondary: .flightGrey500,
            disabled: .flightGrey500.opacity(0.18),
            onDisabled: .flightGrey500.opacity(0.48),
            inputOutput: .flightLightBlue,
            nominal: .flightLightGreen,
            caution: .flightLightYellow,
            warning: .flightLightRed,
            onCore: .flightGrey100,
            graphicsRed: .flightGraphicsRed,
            graphicsYellow: .flightGraphicsYellow,
            graphicsGreen: .flightGraphicsGreen,
            graphicsMint: .flightGraphicsMint,
            graphicsCyan: .flightGraphicsCyan,
            graphicsBlue: .flightGraphicsBlue,
            graphicsIndigo: .flightGraphicsIndigo,
            graphicsPurple: .flightGraphicsPurple,
            graphicsPink: .flightGraphicsPink
        )
    }

    /// Light theme color configuration
    public static var light: ThemeColorData {
        ThemeColorData(
            background: .flightGrey800,
            surfaceLow: .flightGrey700,
            surfaceHigh: .flightGrey600,
            primary: .flightGrey100,
            secondary: .flightGrey300,
            disabled: .flightGrey400.opacity(0.28),
            onDisabled: .flightGrey400.opacity(0.78),
            inputOutput: .flightLightBlue,
            nominal: .flightLightGreen,
            caution: .flightLightYellow,
            warning: .flightLightRed,
            onCore: .flightGrey100,
            graphicsRed: .flightGraphicsRed,
            graphicsYellow: .flightGraphicsYellow,
            graphicsGreen: .flightGraphicsGreen,
            graphicsMint: .flightGraphicsMint,
            graphicsCyan: .flightGraphicsCyan,
            graphicsBlue: .flightGraphicsBlue,
            graphicsIndigo: .flightGraphicsIndigo,
            graphicsPurple: .flightGraphicsPurple,
            graphicsPink: .flightGraphicsPink
        )
    }
}
