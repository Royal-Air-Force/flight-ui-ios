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

## Providing the Theme as an Environment Object
Our recommended approach to utilising FlightUI is to provide the `ThemeManager` and `Theme` object as an Environment variable. This can be achieved by the following steps;

1. Create the `ThemeManager` instance as a State Object within your App Struct. You can provide a customised `Theme` object to the theme manager within it's constructor.
```
import FlightUI

@main
struct MyApp: App {
    @StateObject var themeManager = ThemeManager()
    // or
    @StateObject var themeManager = ThemeManager(current: .dark)
}
```
2. Provide the `themeManager` and `themeManager.current` as environment objects to your navigation stack, and set the colour scheme environment to match.
```
var body: some Scene {
    WindowGroup {
        NavigationStack {
            ...
        }
        .environmentObject(themeManager)
        .environmentObject(themeManager.current)
        .accentColor(themeManager.current.onBackground.default)
        .environment(\.colorScheme, themeManager.current.baseScheme)
    }
}
```
3. When you need to access elements of FlightUI, ensure it is passed through as an environment object and then access it directly inside your View struct
```
struct MyView: View {
    @EnvironmentObject var theme: Theme

    var body: some View {
        VStack {
            ...
        }
        .background(theme.color.surface)
        .padding(.all, theme.padding.grid4x)
    }
}
```
4. If you want to change the theme, for example between light and dark, then access your Theme Manager object as an environment object and call the `updateTheme` function
```
struct ThemeToggleButton: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var theme: Theme

    var body: some View {
        Button("Light Theme", action: { 
                themeManager.updateTheme(.light)
            })
            .buttonStyle(theme.button.filled)
            .padding(.all, theme.padding.grid2x)
    }
}
```
5. By default, calling `updateTheme` will also change the app environment colour scheme to the one defined in your `Theme.baseScheme`, if you have customised this or are managing the environment manually, then you can prevent this by setting `changeBaseTheme` to `false`
```
...
var body: some View {
    Button("Light Theme", action: { 
            themeManager.updateTheme(.light, changeBaseTheme: false)
        })
        .buttonStyle(theme.button.filled)
        .padding(.all, theme.padding.grid2x)
}
```