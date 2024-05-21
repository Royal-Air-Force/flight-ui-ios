//
//  TODCalculator.swift
//  flight-ui-ios
//
//  Created by Appivate 2024
//

import SwiftUI
import FlightUI

struct TODCalculator: View {
    
    @EnvironmentObject var theme: Theme
    @StateObject var viewModel: TODCalculatorViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: theme.padding.grid6x) {
                startOfDescentInput
                descentRateCalculation
            }
            .padding(theme.padding.grid3x)
            .navigationBarTitle(TODCalculator.todCalculatorTitle)
            .toolbar {
                Button(TODCalculator.todCalculatorClear) {
                    viewModel.clearInputs()
                }
            }
        }
    }
    
    var startOfDescentInput: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid2x) {
            Text(TODCalculator.startOfDescentTitle)
                .fontStyle(theme.font.title1)
                .padding([.horizontal, .top], theme.padding.grid3x)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text(TODCalculator.initialAltitudeLabel)
                    .fontStyle(theme.font.bodyBold)
                    .frame(width: 200, alignment: .leading)
                
                InputField(text: $viewModel.initialAltitudeInput,
                           placeholder: TODCalculator.initialAltitudePlaceholder,
                           filter: .doubleOnly)
                .textFieldStyle(.default)
            }
            .padding([.horizontal], theme.padding.grid3x)
            
            HStack {
                Text(TODCalculator.finalAltitudeLabel)
                    .fontStyle(theme.font.bodyBold)
                    .frame(width: 200, alignment: .leading)
                
                InputField(text: $viewModel.finalAltitudeInput,
                           placeholder: TODCalculator.finalAltitudePlaceholder,
                           filter: .doubleOnly)
                .textFieldStyle(.default)
            }
            .padding([.horizontal], theme.padding.grid3x)
            
            HStack {
                Text(TODCalculator.descentAngleLabel)
                    .fontStyle(theme.font.bodyBold)
                    .frame(width: 200, alignment: .leading)
                
                InputField(text: $viewModel.descentAngleInput,
                           placeholder: TODCalculator.descentAnglePlaceholder,
                           bottomLabelConfig: viewModel.descentAngleBottomConfig,
                           filter: .doubleOnly)
                .textFieldStyle(viewModel.descentAngleTextFieldStyle)
            }
            .padding([.horizontal], theme.padding.grid3x)
            
            VStack {
                Text(TODCalculator.descentDistanceTitle)
                    .fontStyle(theme.font.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text(TODCalculator.descentDistanceLabel)
                        .fontStyle(theme.font.bodyBold)
                        .frame(width: 200, alignment: .leading)
                    
                    InputField(text: $viewModel.descentDistanceOutput,
                               filter: .doubleOnly)
                    .textFieldStyle(.advisory)
                }
            }
            .padding([.all], theme.padding.grid3x)
            .cardStyle(.filled)
        }
        .cardStyle(.outline)
    }
    
    var descentRateCalculation: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid2x) {
            Text(TODCalculator.descentRateTitle)
                .fontStyle(theme.font.title1)
                .padding([.horizontal, .top], theme.padding.grid3x)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text(TODCalculator.descentRateLabel)
                    .fontStyle(theme.font.bodyBold)
                    .frame(width: 200, alignment: .leading)
                
                InputField(text: $viewModel.descentRateInput,
                           placeholder: TODCalculator.descentRatePlaceholder,
                           bottomLabelConfig: viewModel.descentRateBottomConfig,
                           filter: .doubleOnly)
                .textFieldStyle(viewModel.descentRateTextFieldStyle)
            }
            .padding([.horizontal], theme.padding.grid3x)
            
            HStack {
                Text(TODCalculator.groundSpeedLabel)
                    .fontStyle(theme.font.bodyBold)
                    .frame(width: 200, alignment: .leading)
                
                InputField(text: $viewModel.groundSpeedInput,
                           placeholder: TODCalculator.groundSpeedPlaceholder,
                           filter: .doubleOnly)
                .textFieldStyle(.default)
            }
            .padding([.horizontal], theme.padding.grid3x)
            
            VStack {
                Text(TODCalculator.verticalSpeedTitle)
                    .fontStyle(theme.font.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text(TODCalculator.verticalSpeedLabel)
                        .fontStyle(theme.font.bodyBold)
                        .frame(width: 200, alignment: .leading)
                    
                    InputField(text: $viewModel.verticalSpeedOutput,
                               filter: .doubleOnly)
                    .textFieldStyle(.advisory)
                }
            }
            .padding([.all], theme.padding.grid3x)
            .cardStyle(.filled)
        }
        .cardStyle(.outline)
    }
    
}
