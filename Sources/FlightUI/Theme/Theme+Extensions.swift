extension Theme {
    
    public static let dark = Theme(
        color: ThemeColors(primary: .flightWhite,
                    onPrimary: ColorState(color: .flightBlack),
                    secondary: .flightLightGrey,
                    onSecondary: ColorState(color: .flightBlack),
                    background: .flightDarkGrey,
                    onBackground: ColorState(color: .flightWhite),
                    surface: .flightGrey,
                    onSurface: ColorState(color: .flightWhite))
    )

    public static let light = Theme(
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
