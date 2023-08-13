import SwiftUI
import FlightUI

@main
struct KitchenSinkApp: App {
    @StateObject var themeManager = ThemeManager()

    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.backgroundColor = UIColor(themeManager.current.color.background)
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                List {
                    NavigationLink(destination: Colours(), label: {
                        Text("Colours")
                    })
                    .listRowBackground(themeManager.current.color.surface)
                    NavigationLink(destination: Typography(), label: {
                        Text("Typography")
                    })
                    .listRowBackground(themeManager.current.color.surface)
                    NavigationLink(destination: Spacing(), label: {
                        Text("Spacing")
                    })
                    .listRowBackground(themeManager.current.color.surface)
                    NavigationLink(destination: Buttons(), label: {
                        Text("Buttons")
                    })
                    .listRowBackground(themeManager.current.color.surface)
                    NavigationLink(destination: Inputs(), label: {
                        Text("Inputs")
                    })
                    .listRowBackground(themeManager.current.color.surface)
                    NavigationLink(destination: Misc(), label: {
                        Text("Misc")
                    })
                    .listRowBackground(themeManager.current.color.surface)
                }
                .padding([.top], themeManager.current.padding.grid1x)
                .scrollContentBackground(.hidden)
                .background(themeManager.current.color.background)
                .navigationBarTitle("FlightUI")
                .navigationBarTitleDisplayMode(.large)
            }
            .environmentObject(themeManager)
            .environmentObject(themeManager.current)
            .accentColor(themeManager.current.color.onBackground.default)
            .environment(\.colorScheme, themeManager.current.baseScheme)
        }
    }
}
