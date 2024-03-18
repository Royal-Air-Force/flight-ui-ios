//
//  KitchenSinkApp.swift
//  Flight UI - Kitchen Sink Sample
//
//  Created by Appivate 2023
//

import SwiftUI
import FlightUI

@main
struct KitchenSinkApp: App {
    @StateObject var themeManager = ThemeManager(current: .dark)
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
                        SampleScreenView(title: "Inputs", destination: Inputs())
                    }

                    Section(
                        header: HeaderTitleView(title: "Demonstrations",
                                                subtitle: "Functional tools for demonstration")
                    ) {
                        SampleScreenView(title: "Unit Converter", destination: UnitConverter())
                        SampleScreenView(title: "Cross Wind calculator", destination: CrossWindCalculator())
                    }

                    .headerProminence(.increased)
                }
                .padding([.top], themeManager.current.padding.grid1x)
                .scrollContentBackground(.hidden)
                .background(themeManager.current.color.background)
                .navigationBarTitle("FlightUI")
                .navigationBarTitleDisplayMode(.large)
                .toolbarBackground(themeManager.current.color.background, for: .navigationBar)
                .toolbar {
                    Toggle("Dark Theme", isOn: $isDarkTheme)
                        .onChange(of: isDarkTheme) { value in
                            if value {
                                themeManager.updateTheme(.dark)
                            } else {
                                themeManager.updateTheme(.light)
                            }
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .green))
                }
            }
            .environmentObject(themeManager)
            .environmentObject(themeManager.current)
            .accentColor(themeManager.current.color.primary)
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

private struct SampleScreenView<Destination: View>: View {
    @EnvironmentObject var theme: Theme

    var title: String
    var destination: Destination

    var body: some View {
        NavigationLink(destination: destination, label: {
            Text(title)
        })
        .listRowBackground(theme.color.surfaceHigh)
    }
}
