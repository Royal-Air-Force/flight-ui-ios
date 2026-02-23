# 📚 Using the Library

## Adding the Package Dependency
- Open your project in Xcode
- Go to 'File' → 'Add Packages...' or select your project in the Editor, go to Package Dependencies, and press the '+'
- Enter the Package URL, which is the GitHub repository URL for this project, https://github.com/Royal-Air-Force/flight-ui-ios
- Select the package
- Select a Dependency Rule, we recommend setting this to 'Up to Next Major Version'
- Click 'Add Package'
- Under 'Add to Target', select your main project target

## Adding the Package Dependency to Multiple Targets
- Select the additional target to add the library to in the Project Editor
- Go to the 'General' tab
- Scroll to 'Frameworks, Libraries, and Embedded Content'
- Click the '+' button and select the FlightUI package from the list
- Click 'Add'

## Providing the Theme

FlightUI uses Swift's `@Observable` macro (iOS 17+) and a custom environment key. The recommended approach is:

1. Create the `ThemeManager` as a `@State` variable in your App struct.
```swift
import FlightUI

@main
struct MyApp: App {
    @State private var themeManager = ThemeManager()
    // or start with a specific theme:
    @State private var themeManager = ThemeManager(.dark)
}
```

2. Apply the theme to your view hierarchy using `.flightTheme()` and set the preferred colour scheme to match.
```swift
var body: some Scene {
    WindowGroup {
        NavigationStack {
            ...
        }
        .flightTheme(themeManager.current)
        .accentColor(themeManager.current.color.primary)
        .preferredColorScheme(themeManager.current.baseScheme == .dark ? .dark : .light)
    }
}
```

3. Access the theme inside any view using `@Environment(\.theme)`.
```swift
struct MyView: View {
    @Environment(\.theme) var theme

    var body: some View {
        VStack {
            ...
        }
        .background(theme.color.background)
        .padding(.all, theme.spacing.grid4x)
    }
}
```

4. To change the theme, call `apply(_:)` on the `ThemeManager`, or use `toggle()` to switch between light and dark.
```swift
struct ThemeToggleButton: View {
    @State private var isDarkTheme = true

    var body: some View {
        Button {
            withAnimation {
                isDarkTheme.toggle()
                themeManager.apply(isDarkTheme ? .dark : .light)
            }
        } label: {
            Text(isDarkTheme ? "Dark" : "Light")
        }
    }
}
```

Alternatively, use `toggle()` as a shorthand:
```swift
themeManager.toggle()
```
