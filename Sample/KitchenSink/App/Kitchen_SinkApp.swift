import SwiftUI
import FlightUI

@main
struct KitchenSinkApp: App {
    @StateObject var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            VStack {
                AppHeader(title: "FlightUI - Kitchen Sink", typograhy: .h2, imageName: "NavBarIcon")

                TabView {
                    Tab1()
                        .tabItem {
                            Label("Inputs", systemImage: "rectangle.and.pencil.and.ellipsis")
                        }

                    Tab2()
                        .tabItem {
                            Label("Typography", systemImage: "textformat.size")
                        }

                    Tab3()
                        .tabItem {
                            Label("Outputs", systemImage: "chart.dots.scatter")
                        }
                }
            }
            .environmentObject(themeManager)
            .environmentObject(themeManager.current)
        }
    }
}
