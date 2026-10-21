import SwiftUI
import FlightUI

struct TODCalculator: View {
    
    @Environment(\.theme) var theme
    @StateObject var viewModel = TODCalculatorViewModel(calculatorService: CalculatorService())
    
    var body: some View {
        ScrollView {
            VStack(spacing: theme.spacing.grid6x) {
                startOfDescentInput
                descentRateCalculation
            }
            .padding(theme.spacing.grid3x)
        }
        .background(theme.color.background)
        .navigationBarTitle(TODCalculator.todCalculatorTitle)
        .toolbar {
            Button(TODCalculator.todCalculatorClear) {
                viewModel.clearInputs()
            }
        }
    }
    
    var startOfDescentInput: some View {
        VStack(alignment: .leading, spacing: theme.spacing.grid2x) {
            Text(TODCalculator.startOfDescentTitle)
                .fontStyle(theme.typography.title1)
                .padding([.horizontal, .top], theme.spacing.grid3x)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text(TODCalculator.initialAltitudeLabel)
                    .fontStyle(theme.typography.bodyBold)
                    .frame(width: 200, alignment: .leading)
                
                InputField(text: $viewModel.initialAltitudeInput,
                           placeholder: TODCalculator.initialAltitudePlaceholder,
                           filter: .doubleOnly)
                .textFieldStyle(.default)
            }
            .padding([.horizontal], theme.spacing.grid3x)
            
            HStack {
                Text(TODCalculator.finalAltitudeLabel)
                    .fontStyle(theme.typography.bodyBold)
                    .frame(width: 200, alignment: .leading)
                
                InputField(text: $viewModel.finalAltitudeInput,
                           placeholder: TODCalculator.finalAltitudePlaceholder,
                           filter: .doubleOnly)
                .textFieldStyle(.default)
            }
            .padding([.horizontal], theme.spacing.grid3x)
            
            HStack {
                Text(TODCalculator.descentAngleLabel)
                    .fontStyle(theme.typography.bodyBold)
                    .frame(width: 200, alignment: .leading)
                
                InputField(text: $viewModel.descentAngleInput,
                           placeholder: TODCalculator.descentAnglePlaceholder,
                           bottomLabelConfig: viewModel.descentAngleBottomConfig,
                           filter: .doubleOnly)
                .textFieldStyle(viewModel.descentAngleTextFieldStyle)
            }
            .padding([.horizontal], theme.spacing.grid3x)
            
            VStack {
                Text(TODCalculator.descentDistanceTitle)
                    .fontStyle(theme.typography.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text(TODCalculator.descentDistanceLabel)
                        .fontStyle(theme.typography.bodyBold)
                        .frame(width: 200, alignment: .leading)
                    
                    InputField(text: $viewModel.descentDistanceOutput)
                    .textFieldStyle(.advisory)
                }
            }
            .padding([.all], theme.spacing.grid3x)
            .cardStyle(.filled)
        }
        .cardStyle(.outline)
    }
    
    var descentRateCalculation: some View {
        VStack(alignment: .leading, spacing: theme.spacing.grid2x) {
            Text(TODCalculator.descentRateTitle)
                .fontStyle(theme.typography.title1)
                .padding([.horizontal, .top], theme.spacing.grid3x)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text(TODCalculator.descentRateLabel)
                    .fontStyle(theme.typography.bodyBold)
                    .frame(width: 200, alignment: .leading)
                
                InputField(text: $viewModel.descentRateInput,
                           placeholder: TODCalculator.descentRatePlaceholder,
                           bottomLabelConfig: viewModel.descentRateBottomConfig,
                           filter: .doubleOnly)
                .textFieldStyle(viewModel.descentRateTextFieldStyle)
            }
            .padding([.horizontal], theme.spacing.grid3x)
            
            HStack {
                Text(TODCalculator.groundSpeedLabel)
                    .fontStyle(theme.typography.bodyBold)
                    .frame(width: 200, alignment: .leading)
                
                InputField(text: $viewModel.groundSpeedInput,
                           placeholder: TODCalculator.groundSpeedPlaceholder,
                           filter: .doubleOnly)
                .textFieldStyle(.default)
            }
            .padding([.horizontal], theme.spacing.grid3x)
            
            VStack {
                Text(TODCalculator.verticalSpeedTitle)
                    .fontStyle(theme.typography.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text(TODCalculator.verticalSpeedLabel)
                        .fontStyle(theme.typography.bodyBold)
                        .frame(width: 200, alignment: .leading)
                    
                    InputField(text: $viewModel.verticalSpeedOutput)
                    .textFieldStyle(.advisory)
                }
            }
            .padding([.all], theme.spacing.grid3x)
            .cardStyle(.filled)
        }
        .cardStyle(.outline)
    }
    
}
