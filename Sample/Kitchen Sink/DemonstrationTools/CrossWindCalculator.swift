//
//  Shape+Extensions.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI
import Foundation
import FlightUI

struct CrossWindCalculator: View {

    @StateObject var viewModel = CrosswindCalculatorViewModel()
    @EnvironmentObject var theme: Theme

    var body: some View {
        ScrollView {
            VStack {
                HStack() {
                    runwayNumber
                    windSpeedInput
                    windDirection
                }
                windspeedOutput
                    .padding([.top],theme.padding.grid8x)
            }
            .padding(theme.padding.grid2x)
            .navigationBarTitle("Crosswind Calculator")
        }
    }

    var runwayNumber: some View {
        MenuField(selection: $viewModel.runwayNumber,
                  options: Array(1...36),
                  placeholder: "1",
                  topLabel: viewModel.runwayNumberLabel)
    }

    var windSpeedInput: some View {
        InputField(text: $viewModel.windSpeed,
                   placeholder: viewModel.windSpeedPlaceholder,
                   topLabel: viewModel.windSpeedLabel,
                   filter: .doubleOnly,
                   maxCharacterCount: 3)
        .textFieldStyle(.default)
    }

    var windDirection: some View {
        InputField(text: $viewModel.windDirection,
                   placeholder: viewModel.windDirectionPlaceholder,
                   topLabel: viewModel.windDirectionLabel,
                   filter: .integerOnly,
                   maxCharacterCount: 3)
        .textFieldStyle(.default)
    }

    var windspeedOutput: some View {
        VStack(alignment: .leading, spacing: 10) {
            InputField(text: $viewModel.crosswindString,
                       placeholder: "",
                       topLabel: viewModel.crosswindLabel,
                       maxCharacterCount: 3)
            .textFieldStyle(.advisory)
            .frame(width: 240)
            .padding(.top, theme.padding.grid2x)

            InputField(text: $viewModel.headwindString,
                       placeholder: "",
                       topLabel: viewModel.headwindLabel
            )

            .textFieldStyle(.advisory)
            .frame(width: 240)
            .padding(.top, theme.padding.grid2x)
        }
    }
}

#if DEBUG

struct CrosswindPreview: PreviewProvider {
    static var theme: Theme = Theme(baseScheme: .dark)
    static var previews: some View {
        CrossWindCalculator()
            .environmentObject(theme)
            .previewDisplayName("CrossWind Calculator")
            .preferredColorScheme(theme.baseScheme)
    }
}

#endif
