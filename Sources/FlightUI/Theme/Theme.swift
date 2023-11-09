import SwiftUI

public class Theme: ObservableObject {
    @Published public var baseScheme: ColorScheme
    @Published public var color: ThemeColors
    @Published public var padding: ThemePadding
    @Published public var size: ThemeSize
    @Published public var radius: ThemeRadius
    @Published public var font: ThemeFont
    @Published public var button: ThemeButtons
    @Published public var cards: ThemeCards

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
    @Published public var validationStatusCaution: Color
    @Published public var validationStatusAdvisory: Color

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
        cards: ThemeCards = ThemeCards(),

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
        self.cards = cards

        self.primaryButtonBackground = color.nominal
        self.primaryButtonForeground = color.onCore
        self.secondaryButtonBackground = color.nominal
        self.secondaryButtonForeground = color.nominal
        self.tertiaryButtonColor = color.primary
        self.tertiaryButtonDisabledColor = color.disabled
        self.staticTextBackground = color.disabled
        self.staticTextBorder = color.primary
        self.textFieldBackground = color.surfaceHigh
        self.menuFieldBackground = color.surfaceHigh
        self.menuFieldAccent = color.primary
        self.header = color.surfaceLow
        self.input = color.inputOutput
        self.result = color.nominal
        self.buttonTypography = color.surfaceLow
        self.caption = color.secondary
        self.emptyField = color.surfaceHigh
        self.dropDownOption = color.inputOutput
        self.panelBackground = color.surfaceLow
        self.panelForegoround = color.surfaceLow
        self.panelViewBackground = color.background
        self.appHeaderBackground = color.background
        self.validationStatusValid = color.surfaceHigh
        self.validationStatusWarning = color.warning
        self.validationStatusCaution = color.caution
        self.validationStatusAdvisory = color.primary
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
