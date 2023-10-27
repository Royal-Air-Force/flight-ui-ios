import SwiftUI

public class ThemeColors {
    // General Colors
    @Published public var background: Color
    @Published public var surfaceLow: Color
    @Published public var surfaceHigh: Color
    @Published public var primary: Color
    @Published public var secondary: Color
    @Published public var disabled: Color
    @Published public var onDisabled: Color

    // Core Colors
    @Published public var inputOutput: Color
    @Published public var nominal: Color
    @Published public var caution: Color
    @Published public var warning: Color
    @Published public var onCore: Color

    // Graphics Colors
    @Published public var graphicsRed: Color
    @Published public var graphicsYellow: Color
    @Published public var graphicsGreen: Color
    @Published public var graphicsMint: Color
    @Published public var graphicsCyan: Color
    @Published public var graphicsBlue: Color
    @Published public var graphicsIndigo: Color
    @Published public var graphicsPurple: Color
    @Published public var graphicsPink: Color

    public init(background: Color = .flightGrey100,
                surfaceLow: Color = .flightGrey200,
                surfaceHigh: Color = .flightGrey300,
                primary: Color = .flightGrey600,
                secondary: Color = .flightGrey500,
                disabled: Color = .flightGrey500.opacity(0.18),
                onDisabled: Color = .flightGrey500.opacity(0.48),
                inputOutput: Color = .flightLightBlue,
                nominal: Color = .flightLightGreen,
                caution: Color = .flightLightYellow,
                warning: Color = .flightLightRed,
                onCore: Color = .flightGrey100,
                graphicsRed: Color = .flightGraphicsRed,
                graphicsYellow: Color = .flightGraphicsYellow,
                graphicsGreen: Color = .flightGraphicsGreen,
                graphicsMint: Color = .flightGraphicsMint,
                graphicsCyan: Color = .flightGraphicsCyan,
                graphicsBlue: Color = .flightGraphicsBlue,
                graphicsIndigo: Color = .flightGraphicsIndigo,
                graphicsPurple: Color = .flightGraphicsPurple,
                graphicsPink: Color = .flightGraphicsPink
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
