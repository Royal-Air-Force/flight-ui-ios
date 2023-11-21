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

    public init(
        baseScheme: ColorScheme = .dark,
        color: ThemeColors = ThemeColors(),
        padding: ThemePadding = ThemePadding(),
        size: ThemeSize = ThemeSize(),
        radius: ThemeRadius = ThemeRadius(),
        font: ThemeFont = ThemeFont(),
        button: ThemeButtons = ThemeButtons(),
        cards: ThemeCards = ThemeCards()
    ) {
        self.baseScheme = baseScheme
        self.color = color
        self.padding = padding
        self.size = size
        self.radius = radius
        self.font = font
        self.button = button
        self.cards = cards
    }
}
