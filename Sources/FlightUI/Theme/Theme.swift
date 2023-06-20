import SwiftUI

public class Theme: ObservableObject {
    // General Colors
    @Published public var primaryColor: Color
    @Published public var onPrimaryColor: ColorState
    
    @Published public var secondaryColor: Color
    @Published public var onSecondaryColor: ColorState
    
    @Published public var backgroundColor: Color
    @Published public var onBackgroundColor: ColorState
    
    @Published public var surfaceColor: Color
    @Published public var onSurfaceColor: ColorState
    
    // Core Colors
    @Published public var inputOutputColor: ColorState
    @Published public var onInputOutputColor: ColorState

    @Published public var nominalColor: ColorState
    @Published public var onNominalColor: ColorState
    
    @Published public var cautionColor: ColorState
    @Published public var onCautionColor: ColorState
    
    @Published public var warningColor: ColorState
    @Published public var onWarningColor: ColorState
    
    // Graphics Colors
    @Published public var graphicsRedColor: Color
    @Published public var graphicsYellowColor: Color
    @Published public var graphicsGreenColor: Color
    @Published public var graphicsMintColor: Color
    @Published public var graphicsCyanColor: Color
    @Published public var graphicsBlueColor: Color
    @Published public var graphicsIndigoColor: Color
    @Published public var graphicsPurpleColor: Color
    @Published public var graphicsPinkColor: Color
    
    
    // Buttons
    @Published public var primaryButtonBackground: Color
    @Published public var primaryButtonForeground: Color
    @Published public var secondaryButtonBackground: Color
    @Published public var secondaryButtonForeground: Color
    @Published public var tertiaryButtonColor: Color
    @Published public var tertiaryButtonDisabledColor: Color

    // Static Text
    @Published public var staticTextBackground: Color
    @Published public var staticTextBorder: Color
    
    // Text Fields
    @Published public var textFieldBackground: Color
    
    // Menu Field
    @Published public var menuFieldBackground: Color
    @Published public var menuFieldAccent: Color
    
    // Typography
    @Published public var header: Color
    @Published public var input: Color
    @Published public var result: Color
    @Published public var buttonTypography: Color
    @Published public var caption: Color
    @Published public var emptyField: Color
    @Published public var dropDownOption: Color
    
    // Misc
    @Published public var panelBackground: Color
    @Published public var panelForegoround: Color
    @Published public var panelViewBackground: Color
    @Published public var appHeaderBackground: Color

    // Validation Status
    @Published public var validationStatusValid: Color
    @Published public var validationStatusWarning: Color
    @Published public var validationStatusError: Color

    // Constants
    @Published public var panelCornerRadius: Double
    @Published public var panelLineWidth: Double
    @Published public var panelPadding: Double
    
    @Published public var buttonHorizontalPadding: Double
    @Published public var buttonVerticalPadding: Double
    @Published public var buttonBorderWidth: Double
    
    @Published public var staticTextFieldCornerRadius: Double
    @Published public var staticTextFieldBorderWidth: Double
    
    @Published public var smallTextFieldWidth: Double
    @Published public var mediumTextFieldWidth: Double
    @Published public var largeTextFieldWidth: Double
    @Published public var textFieldHeight: Double
    @Published public var textFieldCornerRadius: Double
    @Published public var menuFieldHeight: Double
    @Published public var menuFieldCornerRadius: Double

    @Published public var cornerRadius: CornerRadius

    // Opacities
    @Published public var overlayOpacity: Double
    @Published public var disabledButtonOpacity: Double

    // UI Element Spacing
    @Published public var small: Double
    @Published public var medium: Double
    @Published public var large: Double
    @Published public var xlarge: Double
    @Published public var xxlarge: Double
    
    public init(
        // General Colors
        primaryColor: Color = .themePrimary,
        onPrimaryColor: ColorState = ColorState(color: .themeOnPrimary),
        secondaryColor: Color = .themeSecondary,
        onSecondaryColor: ColorState = ColorState(color: .themeOnSecondary),
        backgroundColor: Color = .themeBackground,
        onBackgroundColor: ColorState = ColorState(color: .themeOnBackground),
        surfaceColor: Color = .themeSurface,
        onSurfaceColor: ColorState = ColorState(color: .themeOnSurface),
        
        // Core Colors
        inputOutputColor: ColorState = ColorState(color: .flightInputOutput, focusedColor: .flightInputOutput.opacity(0.87), disabledColor: .themeOnSurface.opacity(0.38)),
        onInputOutputColor: ColorState = ColorState(color: .flightBlack),
        nominalColor: ColorState = ColorState(color: .flightNominal),
        onNominalColor: ColorState = ColorState(color: .flightBlack),
        cautionColor: ColorState = ColorState(color: .flightCaution),
        onCautionColor: ColorState = ColorState(color: .flightBlack),
        warningColor: ColorState = ColorState(color: .flightWarning),
        onWarningColor: ColorState = ColorState(color: .flightBlack),
        
        // Graphics Colors
        graphicsRedColor: Color = .flightGraphicsRed,
        graphicsYellowColor: Color = .flightGraphicsYellow,
        graphicsGreenColor: Color = .flightGraphicsGreen,
        graphicsMintColor: Color = .flightGraphicsMint,
        graphicsCyanColor: Color = .flightGraphicsCyan,
        graphicsBlueColor: Color = .flightGraphicsBlue,
        graphicsIndigoColor: Color = .flightGraphicsIndigo,
        graphicsPurpleColor: Color = .flightGraphicsPurple,
        graphicsPinkColor: Color = .flightGraphicsPink,
        
        primaryButtonBackground: Color = .flightNominal,
        primaryButtonForeground: Color = .flightBlack,
        secondaryButtonBackground: Color = .flightNominal,
        secondaryButtonForeground: Color = .flightNominal,
        tertiaryButtonColor: Color = .flightWhite,
        //tertiaryButtonDisabledColor: Color = .themeOnSurfaceDisabled,
        //staticTextBackground: Color = .themeOnSurfaceDisabled,
        staticTextBorder: Color = .flightWhite,
        textFieldBackground: Color = .themeSurface,
        menuFieldBackground: Color = .themeSurface,
        //menuFieldAccent: Color = .themeOnSurfaceFocused,
        header: Color = .flightWhite,
        input: Color = .flightInputOutput,
        result: Color = .flightNominal,
        buttonTypography: Color = .flightWhite,
        caption: Color = .flightWhite,
        //emptyField: Color = .themeOnSurfaceFocused,
        dropDownOption: Color = .flightInputOutput,
        panelBackground: Color = .themeSurface,
        panelForeground: Color = .flightWhite,
        panelViewBackground: Color = .black,
        appHeaderBackground: Color = .black,
        validationStatusValid: Color = .flightWhite,
        validationStatusWarning: Color = .flightCaution,
        validationStatusError: Color = .flightWarning,
        panelCornerRadius: Double = 5,
        panelLineWidth: Double = 6,
        panelPadding: Double = 6,
        buttonHorizontalPadding: Double = 50,
        buttonVerticalPadding: Double = 12,
        buttonBorderWidth: Double = 3,
        staticTextFieldCornerRadius: Double = 5,
        staticTextFieldBorderWidth: Double = 2,
        smallTextFieldWidth: Double = 84,
        mediumTextFieldWidth: Double = 146,
        largeTextFieldWidth: Double = 226,
        textFieldHeight: Double = 43,
        textFieldCornerRadius: Double = 5,
        menuFieldHeight: Double = 43,
        menuFieldCornerRadius: Double = 5,
        cornerRadius: CornerRadius = CornerRadius(),

        // Opacities
        overlayOpacity: Double = 0.6,
        disabledButtonOpacity: Double = 0.38,

        small: Double = 8,
        medium: Double = 16,
        large: Double = 24,
        xlarge: Double = 32,
        xxlarge: Double = 48
                
    ) {
        self.primaryColor = primaryColor
        self.onPrimaryColor = onPrimaryColor
        self.secondaryColor = secondaryColor
        self.onSecondaryColor = onSecondaryColor
        self.backgroundColor = backgroundColor
        self.onBackgroundColor = onBackgroundColor
        self.surfaceColor = surfaceColor
        self.onSurfaceColor = onSurfaceColor
    
        self.inputOutputColor = inputOutputColor
        self.onInputOutputColor = onInputOutputColor
        self.nominalColor = nominalColor
        self.onNominalColor = onNominalColor
        self.cautionColor = cautionColor
        self.onCautionColor = onCautionColor
        self.warningColor = warningColor
        self.onWarningColor = onWarningColor
        
        self.graphicsRedColor = graphicsRedColor
        self.graphicsYellowColor = graphicsYellowColor
        self.graphicsGreenColor = graphicsGreenColor
        self.graphicsMintColor = graphicsMintColor
        self.graphicsCyanColor = graphicsCyanColor
        self.graphicsBlueColor = graphicsBlueColor
        self.graphicsIndigoColor = graphicsIndigoColor
        self.graphicsPurpleColor = graphicsPurpleColor
        self.graphicsPinkColor = graphicsPinkColor
        
        self.primaryButtonBackground = primaryButtonBackground
        self.primaryButtonForeground = primaryButtonForeground
        self.secondaryButtonBackground = secondaryButtonBackground
        self.secondaryButtonForeground = secondaryButtonForeground
        self.tertiaryButtonColor = tertiaryButtonColor
        self.tertiaryButtonDisabledColor = onSurfaceColor.disabledColor
        self.staticTextBackground = onSurfaceColor.disabledColor
        self.staticTextBorder = staticTextBorder
        self.textFieldBackground = textFieldBackground
        self.menuFieldBackground = menuFieldBackground
        self.menuFieldAccent = onSurfaceColor.focusedColor
        self.header = header
        self.input = input
        self.result = result
        self.buttonTypography = buttonTypography
        self.caption = caption
        self.emptyField = onSurfaceColor.focusedColor
        self.dropDownOption = dropDownOption
        self.panelBackground = panelBackground
        self.panelForegoround = panelForeground
        self.panelViewBackground = panelViewBackground
        self.appHeaderBackground = appHeaderBackground
        self.validationStatusValid = validationStatusValid
        self.validationStatusWarning = validationStatusWarning
        self.validationStatusError = validationStatusError
        self.panelCornerRadius = panelCornerRadius
        self.panelLineWidth = panelLineWidth
        self.panelPadding = panelPadding
        self.buttonHorizontalPadding = buttonHorizontalPadding
        self.buttonVerticalPadding = buttonVerticalPadding
        self.buttonBorderWidth = buttonBorderWidth
        self.staticTextFieldCornerRadius = staticTextFieldCornerRadius
        self.staticTextFieldBorderWidth = staticTextFieldBorderWidth
        self.smallTextFieldWidth = smallTextFieldWidth
        self.mediumTextFieldWidth = mediumTextFieldWidth
        self.largeTextFieldWidth = largeTextFieldWidth
        self.textFieldHeight = textFieldHeight
        self.textFieldCornerRadius = textFieldCornerRadius
        self.menuFieldHeight = menuFieldHeight
        self.menuFieldCornerRadius = menuFieldCornerRadius
        self.cornerRadius = cornerRadius

        // Opacities
        self.overlayOpacity = overlayOpacity
        self.disabledButtonOpacity = disabledButtonOpacity

        self.small = small
        self.medium = medium
        self.large = large
        self.xlarge = xlarge
        self.xxlarge = xxlarge
    }
}
