# 👛 Modifying the Library

## 🎨 Customisation
Although by default FlightUI provides a set of approved components, there may be times where you feel the need to modify certain aspects or elements of the library in order to consistently achieve a desired look within your app.

In order to do this, it is possible to create your own instance of the `Theme` object, and override only the values you wish to change while keeping the defaults the same. You can then provide your customised instance of the `Theme` object to the `ThemeManager`.

The `Theme` object takes in objects either for base level styling or components, such as `ThemeColors` for all the colour information, and `ThemeButtons` for all the button component styling. Changing the background colour of your application to yellow if you were so inclined can be as simple as;

```
@main
struct MyApp: App {
    @StateObject var themeManager = ThemeManager(current: Theme(
        color: ThemeColors(background: .yellow)
    ))
}
```

Where possible, existing SwiftUI structs and protocols have been used, making overriding consistent with implementing a theme from scratch yourself. For example, if you wished to change the `filled` button style, for example modifying the font or the colour, you can create your own implementation of the `ButtonStyle` protocol and provide this as part of your theme;
```
struct MyCustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.largeTitle)
            .background(.blue)
    }
}

@main
struct MyApp: App {
    @StateObject var themeManager = ThemeManager(current: Theme(
        button: ThemeButtons(filled: MyCustomButtonStyle())
    ))
}
```