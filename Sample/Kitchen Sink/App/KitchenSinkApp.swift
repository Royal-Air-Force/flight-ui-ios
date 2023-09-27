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
                    Section(
                        header: HeaderTitleView(title: "Styles",
                                                subtitle: "Base atoms used across components")
                    ) {
                        NavigationLinkView(title: "Cards (TBC)", destination: Misc())
                        NavigationLinkView(title: "Colours", destination: Colours())
                        NavigationLinkView(title: "Navigation (TBC)", destination: Misc())
                        NavigationLinkView(title: "Spacing", destination: Spacing())
                        NavigationLinkView(title: "Typography", destination: Typography())
                    }
                    .headerProminence(.increased)
                    Section(
                        header: HeaderTitleView(title: "Components",
                                                subtitle: "Complex interactable UI components")
                    ) {
                        NavigationLinkView(title: "Banners (TBC)", destination: Misc())
                        NavigationLinkView(title: "Buttons", destination: Buttons())
                        NavigationLinkView(title: "Chips (TBC)", destination: Misc())
                        NavigationLinkView(title: "Inputs", destination: Inputs())
                        NavigationLinkView(title: "Menus (TBC)", destination: Misc())
                        NavigationLinkView(title: "Notifications (TBC)", destination: Misc())
                        NavigationLinkView(title: "Progress (TBC)", destination: Misc())
                        NavigationLinkView(title: "Selection Controls (TBC)", destination: Misc())
                        NavigationLinkView(title: "Sliders (TBC)", destination: Misc())
                        NavigationLinkView(title: "Misc (To Delete)", destination: Misc())
                    }
                    .headerProminence(.increased)
                    Section(
                        header: HeaderTitleView(title: "Aviation",
                                                subtitle: "Components and Functionalities specific to aviation")
                    ) {
                        NavigationLinkView(title: "Flight Crew Alerting", destination: Misc())
                    }
                    .headerProminence(.increased)
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

private struct HeaderTitleView: View {
    @EnvironmentObject var theme: Theme
    
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack {
            Text(title)
                .fontStyle(theme.font.title1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(subtitle)
                .fontStyle(theme.font.body)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private struct NavigationLinkView<Destination: View>: View {
    @EnvironmentObject var theme: Theme
    
    var title: String
    var destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination, label: {
            Text(title)
        })
        .listRowBackground(theme.color.surface)
    }
}
