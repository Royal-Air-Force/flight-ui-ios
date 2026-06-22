import SwiftUI
import FlightUI

@main
struct KitchenSinkApp: App {
    @State private var themeManager = ThemeManager(.dark)
    @State private var isDarkTheme = true

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                List {
                    Section(
                        header: HeaderTitleView(title: "Styles",
                                                subtitle: "Base atoms used across components")
                    ) {
                        SampleScreenView(title: "Colours", destination: Colours())
                        SampleScreenView(title: "Spacing", destination: Spacing())
                        SampleScreenView(title: "Typography", destination: Typography())
                    }
                    .headerProminence(.increased)
                    Section(
                        header: HeaderTitleView(title: "Components",
                                                subtitle: "Complex interactable UI components")
                    ) {
                        SampleScreenView(title: "Buttons", destination: Buttons())
                        SampleScreenView(title: "Cards", destination: Cards())
                        SampleScreenView(title: "Coordinates", destination: Coordinates())
                        SampleScreenView(title: "Inputs", destination: Inputs())
                    }
                    .headerProminence(.increased)

                    Section(
                        header: HeaderTitleView(title: "Demonstrations",
                                                subtitle: "Functional tools for demonstration")
                    ) {
                        SampleScreenView(title: "Unit Converter", destination: UnitConverter())
                    }

                    .headerProminence(.increased)
                }
                .padding([.top], themeManager.current.spacing.grid1x)
                .scrollContentBackground(.hidden)
                .background(themeManager.current.color.background)
                .navigationTitle("FlightUI")
                .toolbarTitleDisplayMode(.inline)
                .toolbarBackground(themeManager.current.color.background, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            withAnimation {
                                isDarkTheme.toggle()
                                themeManager.apply(isDarkTheme ? .dark : .light)
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: isDarkTheme ? "moon.fill" : "sun.max.fill")
                                Text(isDarkTheme ? "Dark" : "Light")
                                    .font(.subheadline)
                            }
                            .foregroundStyle(isDarkTheme ? .yellow : .orange)
                        }
                    }
                }
            }
            .flightTheme(themeManager.current)
            .accentColor(themeManager.current.color.primary)
            .preferredColorScheme(themeManager.current.baseScheme == .dark ? .dark : .light)
        }
    }
}

private struct HeaderTitleView: View {
    @Environment(\.theme) var theme

    var title: String
    var subtitle: String

    var body: some View {
        VStack {
            Text(title)
                .fontStyle(theme.typography.title1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(subtitle)
                .fontStyle(theme.typography.body)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private struct SampleScreenView<Destination: View>: View {
    @Environment(\.theme) var theme

    var title: String
    var destination: Destination

    var body: some View {
        NavigationLink(destination: destination, label: {
            Text(title)
        })
        .listRowBackground(theme.color.surfaceHigh)
    }
}
