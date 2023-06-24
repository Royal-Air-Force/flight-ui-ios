import SwiftUI

public class ThemeColors{
    // General Colors
    @Published var primary: Color
    @Published var onPrimary: ColorState
    @Published var secondary: Color
    @Published var onSecondary: ColorState
    @Published var background: Color
    @Published var onBackground: ColorState
    @Published var surface: Color
    @Published var onSurface: ColorState
    
    // Core Colors
    @Published var inputOutput: ColorState
    @Published var onInputOutput: ColorState
    @Published var nominal: ColorState
    @Published var onNominal: ColorState
    @Published var caution: ColorState
    @Published var onCaution: ColorState
    @Published var warning: ColorState
    @Published var onWarning: ColorState
    
    // Graphics Colors
    @Published var graphicsRed: Color
    @Published var graphicsYellow: Color
    @Published var graphicsGreen: Color
    @Published var graphicsMint: Color
    @Published var graphicsCyan: Color
    @Published var graphicsBlue: Color
    @Published var graphicsIndigo: Color
    @Published var graphicsPurple: Color
    @Published var graphicsPink: Color
    
    public init(primary: Color = .themePrimary,
                onPrimary: ColorState = ColorState(color: .themeOnPrimary),
                secondary: Color = .themeSecondary,
                onSecondary: ColorState = ColorState(color: .themeOnSecondary),
                background: Color = .themeBackground,
                onBackground: ColorState = ColorState(color: .themeOnBackground),
                surface: Color = .themeSurface,
                onSurface: ColorState = ColorState(color: .themeOnSurface),
                inputOutput: ColorState = ColorState(color: .flightInputOutput, focusedColor: .flightInputOutput.opacity(0.87), disabledColor: .themeOnSurface.opacity(0.38)),
                onInputOutput: ColorState = ColorState(color: .flightBlack),
                nominal: ColorState = ColorState(color: .flightNominal),
                onNominal: ColorState = ColorState(color: .flightBlack),
                caution: ColorState = ColorState(color: .flightCaution),
                onCaution: ColorState = ColorState(color: .flightBlack),
                warning: ColorState = ColorState(color: .flightWarning),
                onWarning: ColorState = ColorState(color: .flightBlack),
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
