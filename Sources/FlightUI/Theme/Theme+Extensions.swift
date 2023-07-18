extension Theme {

    public static let dark = Theme(
        baseScheme: .dark,
        color: ThemeColors(primary: .flightWhite,
                           onPrimary: ColorState(color: .flightBlack),
                           secondary: .flightLightGrey,
                           onSecondary: ColorState(color: .flightBlack),
                           background: .flightBlack,
                           onBackground: ColorState(color: .flightWhite),
                           surface: .flightDarkGrey,
                           onSurface: ColorState(color: .flightWhite))
    )

    public static let light = Theme(
        baseScheme: .light,
        color: ThemeColors(primary: .flightBlack,
                           onPrimary: ColorState(color: .flightWhite),
                           secondary: .flightDarkGrey,
                           onSecondary: ColorState(color: .flightWhite),
                           background: .flightWhite,
                           onBackground: ColorState(color: .flightBlack),
                           surface: .flightLightGrey,
                           onSurface: ColorState(color: .flightBlack))
    )
}
