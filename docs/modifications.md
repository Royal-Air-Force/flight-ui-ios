# 👛 Modifying the Library

## 🎨 Customisation
Although by default FlightUI provides a set of approved components, there may be times where you need to modify certain aspects to achieve a consistent look within your app.

`ThemeData` is an immutable struct, so customisation is done by creating a modified copy using the provided `with...` methods. You then pass the custom `ThemeData` to your `ThemeManager`.

For example, to change the background colour:
```swift
@main
struct MyApp: App {
    @State private var themeManager = ThemeManager(
        .dark.withColors(ThemeColorData(
            background: .yellow,
            // ... all other required colour properties
        ))
    )
}
```

For smaller targeted changes, the `with...` convenience methods on `ThemeData` make it straightforward to override a single aspect while keeping all other defaults:
```swift
// Override only spacing
let customTheme = ThemeData.dark.withSpacing(ThemeSpacingData(
    grid0_5x: 2, grid1x: 4, grid1_5x: 6, grid2x: 8,
    grid2_5x: 10, grid3x: 12, grid4x: 16, grid5x: 20,
    grid6x: 24, grid7x: 28, grid8x: 32, grid9x: 36, grid10x: 40
))
```

The full set of `with...` methods available on `ThemeData` is:
- `withColors(_ colors: ThemeColorData) -> ThemeData`
- `withSpacing(_ spacing: ThemeSpacingData) -> ThemeData`
- `withSize(_ size: ThemeSizeData) -> ThemeData`
- `withRadius(_ radius: ThemeRadiusData) -> ThemeData`
- `withTypography(_ typography: ThemeTypographyData) -> ThemeData`

There is also a `scaled(by:)` method that proportionally scales spacing, size, radius, and typography by a given factor — useful for density or accessibility adjustments:
```swift
let compactTheme = ThemeData.dark.scaled(by: 0.75)
```
