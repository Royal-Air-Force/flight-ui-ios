import SwiftUI

public class Theme: ObservableObject {
    @Published public var baseScheme: ColorScheme
    @Published public var color: ThemeColors
    @Published public var padding: ThemePadding
    @Published public var size: ThemeSize
    @Published public var radius: ThemeRadius
    @Published public var font: ThemeFont
    @Published public var button: ThemeButtons
    
    
    
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
        baseScheme: ColorScheme = .dark,
        color: ThemeColors = ThemeColors(),
        padding: ThemePadding = ThemePadding(),
        size: ThemeSize = ThemeSize(),
        radius: ThemeRadius = ThemeRadius(),
        font: ThemeFont = ThemeFont(),
        button: ThemeButtons = ThemeButtons(),

        // Opacities
        overlayOpacity: Double = 0.6,
        disabledButtonOpacity: Double = 0.38
                
    ) {
        self.baseScheme = baseScheme
        self.color = color
        self.padding = padding
        self.size = size
        self.radius = radius
        self.font = font
        self.button = button
        
        self.primaryButtonBackground = color.nominal.default
        self.primaryButtonForeground = color.onNominal.default
        self.secondaryButtonBackground = color.nominal.default
        self.secondaryButtonForeground = color.nominal.default
        self.tertiaryButtonColor = color.onSurface.default
        self.tertiaryButtonDisabledColor = color.onSurface.disabledColor
        self.staticTextBackground = color.onSurface.disabledColor
        self.staticTextBorder = color.onSurface.default
        self.textFieldBackground = color.surface
        self.menuFieldBackground = color.surface
        self.menuFieldAccent = color.onSurface.focusedColor
        self.header = color.onSurface.default
        self.input = color.inputOutput.default
        self.result = color.nominal.default
        self.buttonTypography = color.onSurface.default
        self.caption = color.onSurface.default
        self.emptyField = color.onSurface.focusedColor
        self.dropDownOption = color.inputOutput.default
        self.panelBackground = color.surface
        self.panelForegoround = color.onSurface.default
        self.panelViewBackground = color.background
        self.appHeaderBackground = color.background
        self.validationStatusValid = color.onSurface.default
        self.validationStatusWarning = color.caution.default
        self.validationStatusError = color.warning.default
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
