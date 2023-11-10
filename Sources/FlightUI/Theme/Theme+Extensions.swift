extension Theme {

    public static let dark = Theme(
        baseScheme: .dark,
        color: ThemeColors(background: .flightGrey100,
                           surfaceLow: .flightGrey200,
                           surfaceHigh: .flightGrey300,
                           primary: .flightGrey600,
                           secondary: .flightGrey500,
                           disabled: .flightGrey500.opacity(0.18),
                           onDisabled: .flightGrey500.opacity(0.48),
                           inputOutput: .flightLightBlue,
                           nominal: .flightLightGreen,
                           caution: .flightLightYellow,
                           warning: .flightLightRed,
                           onCore: .flightGrey100)
    )

    public static let light = Theme(
        baseScheme: .light,
        color: ThemeColors(background: .flightGrey800,
                           surfaceLow: .flightGrey900,
                           surfaceHigh: .flightGrey700,
                           primary: .flightGrey100,
                           secondary: .flightGrey400,
                           disabled: .flightGrey400.opacity(0.28),
                           onDisabled: .flightGrey400.opacity(0.78),
                           inputOutput: .flightDarkBlue,
                           nominal: .flightDarkGreen,
                           caution: .flightDarkYellow,
                           warning: .flightDarkRed,
                           onCore: .flightGrey800,
                           graphicsRed: .flightGraphicsDarkRed,
                           graphicsYellow: .flightGraphicsDarkYellow,
                           graphicsGreen: .flightGraphicsDarkGreen,
                           graphicsMint: .flightGraphicsDarkMint,
                           graphicsCyan: .flightGraphicsDarkCyan,
                           graphicsBlue: .flightGraphicsDarkBlue,
                           graphicsPurple: .flightGraphicsDarkPurple,
                           graphicsPink: .flightGraphicsDarkPink)
    )
}
