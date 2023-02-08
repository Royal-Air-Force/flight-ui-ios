import SwiftUI

public class Theme: ObservableObject {
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

    // UI Element Spacing
    @Published public var small: Double
    @Published public var medium: Double
    @Published public var large: Double
    @Published public var xlarge: Double
    @Published public var xxlarge: Double
    
    public init(primaryButtonBackground: Color = .flightGreen,
                primaryButtonForeground: Color = .flightBlack,
                secondaryButtonBackground: Color = .flightGreen,
                secondaryButtonForeground: Color = .flightGreen,
                tertiaryButtonColor: Color = .flightWhite,
                tertiaryButtonDisabledColor: Color = .flightLightGray,
                staticTextBackground: Color = .flightDarkGray,
                staticTextBorder: Color = .flightWhite,
                textFieldBackground: Color = .flightDarkGray,
                menuFieldBackground: Color = .flightDarkGray,
                menuFieldAccent: Color = .flightLightGray,
                header: Color = .flightWhite,
                input: Color = .flightBlue,
                result: Color = .flightGreen,
                buttonTypography: Color = .flightWhite,
                caption: Color = .flightWhite,
                emptyField: Color = .flightLightGray,
                dropDownOption: Color = .flightBlue,
                panelBackground: Color = .flightDarkGray,
                panelForeground: Color = .flightWhite,
                panelViewBackground: Color = .black,
                appHeaderBackground: Color = .black,
                panelCornerRadius: Double = 16,
                panelLineWidth: Double = 6,
                panelPadding: Double = 6,
                buttonHorizontalPadding: Double = 50,
                buttonVerticalPadding: Double = 12,
                buttonBorderWidth: Double = 3,
                staticTextFieldCornerRadius: Double = 5,
                staticTextFieldBorderWidth: Double = 3,
                smallTextFieldWidth: Double = 84,
                mediumTextFieldWidth: Double = 146,
                largeTextFieldWidth: Double = 226,
                textFieldHeight: Double = 43,
                textFieldCornerRadius: Double = 5,
                menuFieldHeight: Double = 43,
                menuFieldCornerRadius: Double = 5,
                small: Double = 8,
                medium: Double = 16,
                large: Double = 24,
                xlarge: Double = 32,
                xxlarge: Double = 48
                
    ) {
        self.primaryButtonBackground = primaryButtonBackground
        self.primaryButtonForeground = primaryButtonForeground
        self.secondaryButtonBackground = secondaryButtonBackground
        self.secondaryButtonForeground = secondaryButtonForeground
        self.tertiaryButtonColor = tertiaryButtonColor
        self.tertiaryButtonDisabledColor = tertiaryButtonDisabledColor
        self.staticTextBackground = staticTextBackground
        self.staticTextBorder = staticTextBorder
        self.textFieldBackground = textFieldBackground
        self.menuFieldBackground = menuFieldBackground
        self.menuFieldAccent = menuFieldAccent
        self.header = header
        self.input = input
        self.result = result
        self.buttonTypography = buttonTypography
        self.caption = caption
        self.emptyField = emptyField
        self.dropDownOption = dropDownOption
        self.panelBackground = panelBackground
        self.panelForegoround = panelForeground
        self.panelViewBackground = panelViewBackground
        self.appHeaderBackground = appHeaderBackground
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
        self.small = small
        self.medium = medium
        self.large = large
        self.xlarge = xlarge
        self.xxlarge = xxlarge
    }
}
