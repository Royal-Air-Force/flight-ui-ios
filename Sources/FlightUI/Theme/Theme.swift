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
    @Published public var textFieldForeground: Color
    
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
    
    
    public init(primaryButtonBackground: Color = .flightGreen,
                primaryButtonForeground: Color = .flightBlack,
                secondaryButtonBackground: Color = .flightGreen,
                secondaryButtonForeground: Color = .flightGreen,
                tertiaryButtonColor: Color = .flightWhite,
                tertiaryButtonDisabledColor: Color = .flightLightGray,
                staticTextBackground: Color = .flightDarkGray,
                staticTextBorder: Color = .flightWhite,
                textFieldBackground: Color = .flightDarkGray,
                textFieldForeground: Color = .flightBlue,
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
                appHeaderBackground: Color = .flightBlack) {
        self.primaryButtonBackground = primaryButtonBackground
        self.primaryButtonForeground = primaryButtonForeground
        self.secondaryButtonBackground = secondaryButtonBackground
        self.secondaryButtonForeground = secondaryButtonForeground
        self.tertiaryButtonColor = tertiaryButtonColor
        self.tertiaryButtonDisabledColor = tertiaryButtonDisabledColor
        self.staticTextBackground = staticTextBackground
        self.staticTextBorder = staticTextBorder
        self.textFieldBackground = textFieldBackground
        self.textFieldForeground = textFieldForeground
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
    }
}
