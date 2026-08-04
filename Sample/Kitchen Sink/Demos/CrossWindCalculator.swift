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
    @EnvironmentObject var theme: Theme
    @StateObject var viewModel = CrosswindCalculatorViewModel(calculatorService: CalculatorService())

    var body: some View {
        ScrollView {
            VStack(spacing: theme.padding.grid6x) {
                windSpeedInput
                windspeedOutput
            }
            .padding(theme.padding.grid3x)
            .navigationBarTitle(CrossWindCalculator.crosswindTitle)
        }
    }

    var windSpeedInput: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid2x) {
            HStack {
                Text(CrossWindCalculator.runwayHeadingLabel)
                    .fontStyle(theme.font.bodyBold)
                    .frame(width: 200, alignment: .leading)
                
                MenuField(selection: $viewModel.runwayHeading,
                          options: Array(1...36),
                          placeholder: CrossWindCalculator.runwayHeadingPlaceholder)
            }
            
            HStack {
                Text(CrossWindCalculator.windSpeedLabel)
                    .fontStyle(theme.font.bodyBold)
                    .frame(width: 200, alignment: .leading)
                
                InputField(text: $viewModel.windSpeed,
                           placeholder: CrossWindCalculator.windSpeedPlaceholder,
                           filter: .doubleOnly)
                .textFieldStyle(.default)
            }
            
            HStack {
                Text(CrossWindCalculator.windDirectionLabel)
                    .fontStyle(theme.font.bodyBold)
                    .frame(width: 200, alignment: .leading)
                
                InputField(text: $viewModel.windDirection,
                           placeholder: CrossWindCalculator.windDirectionPlaceholder,
                           bottomLabelConfig: viewModel.windDirectionBottomConfig,
                           filter: .integerOnly,
                           maxCharacterCount: 3)
                .textFieldStyle(viewModel.windDirectionTextFieldStyle)
            }
        }
        .padding([.all], theme.padding.grid3x)
        .cardStyle(.filled)
    }

    var windspeedOutput: some View {
        VStack(spacing: theme.padding.grid2x) {
            Text(CrossWindCalculator.crosswindResultsTitle)
                .fontStyle(theme.font.title1)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: theme.padding.grid4x) {
                VStack {
                    Text(CrossWindCalculator.crosswindLabel)
                        .fontStyle(theme.font.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    InputField(text: $viewModel.crosswindOutput,
                               placeholder: "")
                    .textFieldStyle(.advisory)
                }
                .padding([.all], theme.padding.grid2x)
                .cardStyle(.filled)
                
                VStack {
                    Text(CrossWindCalculator.headwindLabel)
                        .fontStyle(theme.font.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    InputField(text: $viewModel.headwindOutput,
                               placeholder: "")
                    .textFieldStyle(.advisory)
                }
                .padding([.all], theme.padding.grid2x)
                .cardStyle(.filled)
            }
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
