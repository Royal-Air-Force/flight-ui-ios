import SwiftUI
import FlightUI

@main
struct KitchenSinkApp: App {
    @State private var themeManager = ThemeManager(.dark)
    @State private var isDarkTheme = true

    var body: some Scene {
        WindowGroup {
            VStack(spacing: 0) {
                AssuranceBanner()
                
                ToggleBanner(isDarkTheme: $isDarkTheme, themeManager: themeManager)
                
                NavigationStack {
                    List {
                        Section(
                            header: HeadingView(title: "Styles",
                                                subTitle: "Base atoms used across components")
                        ) {
                            SampleScreenView(title: "Colours", destination: Colours())
                            SampleScreenView(title: "Spacing", destination: Spacing())
                            SampleScreenView(title: "Typography", destination: Typography())
                        }
                        .headerProminence(.increased)
                        Section(
                            header: HeadingView(title: "Components",
                                                subTitle: "Complex interactable UI components")
                        ) {
                            SampleScreenView(title: "Buttons", destination: Buttons())
                            SampleScreenView(title: "Cards", destination: Cards())
                            SampleScreenView(title: "Inputs", destination: Inputs())
                        }
                        .headerProminence(.increased)
                        
                        Section(
                            header: HeadingView(title: "Demos",
                                                subTitle: "Functional tools for demonstrating use of FlightUI")
                        ) {
                            SampleScreenView(title: "Unit Converter", destination: UnitConverter())
                            SampleScreenView(title: "Cross Wind Calculator", destination: CrossWindCalculator())
                            SampleScreenView(title: "Top of Descent (TOD) Calculator", destination: TODCalculator())
                        }
                        .headerProminence(.increased)
                    }
                    .scrollContentBackground(.hidden)
                    .background(themeManager.current.color.background)
                    .navigationBarTitle("FlightUI")
                    .navigationBarTitleDisplayMode(.large)
                    .toolbarBackground(themeManager.current.color.background, for: .navigationBar)
                }
            }
            .flightTheme(themeManager.current)
            .accentColor(themeManager.current.color.primary)
            .preferredColorScheme(themeManager.current.baseScheme == .dark ? .dark : .light)
        }
    }
}

private struct ToggleBanner: View {
    @Environment(\.theme) private var theme
    @Binding var isDarkTheme: Bool
    var themeManager: ThemeManager

    var body: some View {
        Toggle("Dark Theme", isOn: $isDarkTheme)
            .onChange(of: isDarkTheme) { _, newValue in
                themeManager.apply(newValue ? .dark : .light)
            }
            .toggleStyle(SwitchToggleStyle(tint: .green))
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(theme.color.surfaceHigh)
            )
            .padding([.horizontal, .top], 20)
    }
}

private struct AssuranceBanner: View {
    @Environment(\.theme) private var theme
    
    var body: some View {
        HStack {
            Text("TRIALS USE ONLY (NOT ASSURED) MUST NOT BE USED AS A PRIMARY REFERENCE")
                .fontStyle(.subhead)
                .fontWeight(.bold)
                .padding(theme.spacing.grid2x)
                .frame(maxWidth: .infinity)
        }
        .background(.red)
    }
}

private struct SampleScreenView<Destination: View>: View {
    @Environment(\.theme) private var theme

    var title: String
    var destination: Destination

    var body: some View {
        NavigationLink(destination: destination, label: {
            Text(title)
        })
        .listRowBackground(theme.color.surfaceHigh)
    }
}
