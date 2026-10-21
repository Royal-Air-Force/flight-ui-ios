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
    @Environment(\.theme) var theme
    @StateObject var viewModel = CrosswindCalculatorViewModel(calculatorService: CalculatorService())

    var body: some View {
        ScrollView {
            VStack(spacing: theme.spacing.grid6x) {
                windSpeedInput
                windspeedOutput
            }
            .padding(theme.spacing.grid3x)
        }
        .background(theme.color.background)
        .navigationBarTitle(CrossWindCalculator.crosswindTitle)
    }

    var windSpeedInput: some View {
        VStack(alignment: .leading, spacing: theme.spacing.grid2x) {
            HStack {
                Text(CrossWindCalculator.runwayHeadingLabel)
                    .fontStyle(theme.typography.bodyBold)
                    .frame(width: 200, alignment: .leading)
                
                MenuField(selection: $viewModel.runwayHeading,
                          options: Array(1...36),
                          placeholder: CrossWindCalculator.runwayHeadingPlaceholder)
            }
            
            HStack {
                Text(CrossWindCalculator.windSpeedLabel)
                    .fontStyle(theme.typography.bodyBold)
                    .frame(width: 200, alignment: .leading)
                
                InputField(text: $viewModel.windSpeed,
                           placeholder: CrossWindCalculator.windSpeedPlaceholder,
                           filter: .doubleOnly)
                .textFieldStyle(.default)
            }
            
            HStack {
                Text(CrossWindCalculator.windDirectionLabel)
                    .fontStyle(theme.typography.bodyBold)
                    .frame(width: 200, alignment: .leading)
                
                InputField(text: $viewModel.windDirection,
                           placeholder: CrossWindCalculator.windDirectionPlaceholder,
                           bottomLabelConfig: viewModel.windDirectionBottomConfig,
                           filter: .integerOnly,
                           maxCharacterCount: 3)
                .textFieldStyle(viewModel.windDirectionTextFieldStyle)
            }
        }
        .padding([.all], theme.spacing.grid3x)
        .cardStyle(.filled)
    }

    var windspeedOutput: some View {
        VStack(spacing: theme.spacing.grid2x) {
            Text(CrossWindCalculator.crosswindResultsTitle)
                .fontStyle(theme.typography.title1)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: theme.spacing.grid4x) {
                VStack {
                    Text(CrossWindCalculator.crosswindLabel)
                        .fontStyle(theme.typography.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    InputField(text: $viewModel.crosswindOutput,
                               placeholder: "")
                    .textFieldStyle(.advisory)
                }
                .padding([.all], theme.spacing.grid2x)
                .cardStyle(.filled)
                
                VStack {
                    Text(CrossWindCalculator.headwindLabel)
                        .fontStyle(theme.typography.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    InputField(text: $viewModel.headwindOutput,
                               placeholder: "")
                    .textFieldStyle(.advisory)
                }
                .padding([.all], theme.spacing.grid2x)
                .cardStyle(.filled)
            }
        }
    }
}

#if DEBUG

struct CrosswindPreview: PreviewProvider {
    static var theme: ThemeData = .dark
    static var previews: some View {
        CrossWindCalculator()
            .previewDisplayName("CrossWind Calculator")
            .preferredColorScheme(theme.baseScheme)
    }
}

#endif
