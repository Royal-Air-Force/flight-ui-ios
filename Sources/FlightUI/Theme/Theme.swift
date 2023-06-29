import SwiftUI

public class Theme: ObservableObject {
    @Published public var color: ThemeColors
    @Published public var padding: ThemePadding
    @Published public var size: ThemeSize
    @Published public var radius: ThemeRadius
    @Published public var typography: ThemeTypography
    
    
    
    // All of the below is to be removed and consolidated into the above objects
    
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
    @Published public var panelCornerRadius: CGFloat
    @Published public var panelLineWidth: CGFloat
    @Published public var panelPadding: CGFloat
    
    @Published public var buttonHorizontalPadding: CGFloat
    @Published public var buttonVerticalPadding: CGFloat
    @Published public var buttonBorderWidth: CGFloat
    
    @Published public var staticTextFieldCornerRadius: CGFloat
    @Published public var staticTextFieldBorderWidth: CGFloat
    
    @Published public var smallTextFieldWidth: CGFloat
    @Published public var mediumTextFieldWidth: CGFloat
    @Published public var largeTextFieldWidth: CGFloat
    @Published public var textFieldHeight: CGFloat
    @Published public var textFieldCornerRadius: CGFloat
    @Published public var menuFieldHeight: CGFloat
    @Published public var menuFieldCornerRadius: CGFloat


    // Opacities
    @Published public var overlayOpacity: Double
    @Published public var disabledButtonOpacity: Double
    
    public init(
        color: ThemeColors = ThemeColors(),
        padding: ThemePadding = ThemePadding(),
        size: ThemeSize = ThemeSize(),
        radius: ThemeRadius = ThemeRadius(),
        typography: ThemeTypography = ThemeTypography(),
        
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
        panelViewBackground: Color = .flightBlack,
        appHeaderBackground: Color = .flightBlack,
        validationStatusValid: Color = .flightWhite,
        validationStatusWarning: Color = .flightCaution,
        validationStatusError: Color = .flightWarning,
//        panelCornerRadius: Double = 5,
//        panelLineWidth: Double = 6,
//        panelPadding: Double = 6,
//        buttonHorizontalPadding: Double = 50,
//        buttonVerticalPadding: Double = 12,
//        buttonBorderWidth: Double = 3,
//        staticTextFieldCornerRadius: Double = 5,
//        staticTextFieldBorderWidth: Double = 2,
//        smallTextFieldWidth: Double = 84,
//        mediumTextFieldWidth: Double = 146,
//        largeTextFieldWidth: Double = 226,
//        textFieldHeight: Double = 43,
//        textFieldCornerRadius: Double = 5,
//        menuFieldHeight: Double = 43,
//        menuFieldCornerRadius: Double = 5,

        // Opacities
        overlayOpacity: Double = 0.6,
        disabledButtonOpacity: Double = 0.38
                
    ) {
        self.color = color
        self.padding = padding
        self.size = size
        self.radius = radius
        self.typography = typography
        
        self.primaryButtonBackground = primaryButtonBackground
        self.primaryButtonForeground = primaryButtonForeground
        self.secondaryButtonBackground = secondaryButtonBackground
        self.secondaryButtonForeground = secondaryButtonForeground
        self.tertiaryButtonColor = tertiaryButtonColor
        self.tertiaryButtonDisabledColor = color.onSurface.disabledColor
        self.staticTextBackground = color.onSurface.disabledColor
        self.staticTextBorder = staticTextBorder
        self.textFieldBackground = textFieldBackground
        self.menuFieldBackground = menuFieldBackground
        self.menuFieldAccent = color.onSurface.focusedColor
        self.header = header
        self.input = input
        self.result = result
        self.buttonTypography = buttonTypography
        self.caption = caption
        self.emptyField = color.onSurface.focusedColor
        self.dropDownOption = dropDownOption
        self.panelBackground = panelBackground
        self.panelForegoround = panelForeground
        self.panelViewBackground = panelViewBackground
        self.appHeaderBackground = appHeaderBackground
        self.validationStatusValid = validationStatusValid
        self.validationStatusWarning = validationStatusWarning
        self.validationStatusError = validationStatusError
        self.panelCornerRadius = radius.medium
        self.panelLineWidth = size.border
        self.panelPadding = padding.grid1x
        self.buttonHorizontalPadding = padding.grid6x
        self.buttonVerticalPadding = padding.grid1_5x
        self.buttonBorderWidth = size.border
        self.staticTextFieldCornerRadius = radius.medium
        self.staticTextFieldBorderWidth = size.border
        self.smallTextFieldWidth = 84
        self.mediumTextFieldWidth = 146
        self.largeTextFieldWidth = 226
        self.textFieldHeight = size.medium
        self.textFieldCornerRadius = radius.medium
        self.menuFieldHeight = size.medium
        self.menuFieldCornerRadius = radius.medium
        
        // Opacities
        self.overlayOpacity = overlayOpacity
        self.disabledButtonOpacity = disabledButtonOpacity
    }
}
