import SwiftUI

public class ThemeColors {
    // General Colors
    @Published public var primary: Color
    @Published public var onPrimary: ColorState
    @Published public var secondary: Color
    @Published public var onSecondary: ColorState
    @Published public var background: Color
    @Published public var onBackground: ColorState
    @Published public var surface: Color
    @Published public var onSurface: ColorState
    
    // Core Colors
    @Published public var inputOutput: ColorState
    @Published public var onInputOutput: ColorState
    @Published public var nominal: ColorState
    @Published public var onNominal: ColorState
    @Published public var advisory: ColorState
    @Published public var onAdvisory: ColorState
    @Published public var caution: ColorState
    @Published public var onCaution: ColorState
    @Published public var warning: ColorState
    @Published public var onWarning: ColorState
    
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
    
    public init(primary: Color = .flightWhite,
                onPrimary: ColorState = ColorState(color: .flightBlack),
                secondary: Color = .flightLightGrey,
                onSecondary: ColorState = ColorState(color: .flightBlack),
                background: Color = .flightBlack,
                onBackground: ColorState = ColorState(color: .flightWhite),
                surface: Color = .flightDarkGrey,
                onSurface: ColorState = ColorState(color: .flightWhite),
                inputOutput: ColorState = ColorState(color: .flightInputOutput, focusedColor: .flightInputOutput.opacity(0.87), disabledColor: .flightWhite.opacity(0.38)),
                onInputOutput: ColorState = ColorState(color: .flightBlack),
                nominal: ColorState = ColorState(color: .flightNominal),
                onNominal: ColorState = ColorState(color: .flightBlack),
                caution: ColorState = ColorState(color: .flightCaution),
                onCaution: ColorState = ColorState(color: .flightBlack),
                warning: ColorState = ColorState(color: .flightWarning),
                onWarning: ColorState = ColorState(color: .flightBlack),
                advisory: ColorState = ColorState(color: .flightNominal),
                onAdvisory: ColorState = ColorState(color: .flightBlack),
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
        self.primary = primary
        self.onPrimary = onPrimary
        self.secondary = secondary
        self.onSecondary = onSecondary
        self.background = background
        self.onBackground = onBackground
        self.surface = surface
        self.onSurface = onSurface
        
        self.inputOutput = inputOutput
        self.onInputOutput = onInputOutput
        self.nominal = nominal
        self.onNominal = onNominal
        self.advisory = advisory
        self.onAdvisory = onAdvisory
        self.caution = caution
        self.onCaution = onCaution
        self.warning = warning
        self.onWarning = onWarning
        
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
