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
            VStack(spacing: 0) {
                AssuranceBanner()
                
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
                            SampleScreenView(title: "Top of Descent (TOD) Calculator", destination: TODCalculator(viewModel: TODCalculatorViewModel()))
                        }
                        .headerProminence(.increased)
                    }
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
            }
            .environmentObject(themeManager)
            .environmentObject(themeManager.current)
            .accentColor(themeManager.current.color.primary)
            .environment(\.colorScheme, themeManager.current.baseScheme)
        }
    }
}

private struct AssuranceBanner: View {
    @EnvironmentObject var theme: Theme
    
    var body: some View {
        HStack {
            Text("TRIALS USE ONLY (NOT ASSURED) MUST NOT BE USED AS A PRIMARY REFERENCE")
                .fontStyle(.subhead)
                .fontWeight(.bold)
                .padding(theme.padding.grid2x)
                .frame(maxWidth: .infinity)
        }
        .background(.red)
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
