import SwiftUI
import FlightUI

struct Inputs: View {
    @EnvironmentObject var theme: Theme
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                textInput
                    .padding(.top, theme.padding.grid2x)

                numberInput
                    .padding(.top, theme.padding.grid2x)
                
                advisoryInput
                    .padding(.top, theme.padding.grid2x)
                
                cautionInput
                    .padding(.top, theme.padding.grid2x)
                
                warningInput
                    .padding(.top, theme.padding.grid2x)
                
                optionalSelectInput
                    .padding(.top, theme.padding.grid2x)
                
                mandatorySelectInput
                    .padding(.top, theme.padding.grid2x)
            }
            
        }
        .navigationBarTitle("Inputs")
    }
    
    var textInput: some View {
        VStack(alignment: .leading) {
            Text("Full Length Textual Input")
                .fontStyle(theme.font.caption1)
            InputField("Select", text: $viewModel.textualInput)
        }
    }
    
    var numberInput: some View {
        VStack(alignment: .leading) {
            Text("Numerical Input with Validation")
                .fontStyle(theme.font.caption1)
            InputField("0 - 100", text: $viewModel.numericalInput, configuration: .inputFieldConfiguration(valueType: .decimal))
            InputMessage()
        }
    }
    
    var advisoryInput: some View {
        VStack(alignment: .leading) {
            Text("Advisory Input")
                .fontStyle(theme.font.caption1)
            InputField("Advisory", text: $viewModel.advisoryInput, configuration: .inputFieldConfiguration(valueType: .decimal))
            InputMessage()
        }
        .validated(by: viewModel.validateAdvisory, status: $viewModel.advisoryInputResult)
    }
    
    var cautionInput: some View {
        VStack(alignment: .leading) {
            Text("Caution Input")
                .fontStyle(theme.font.caption1)
            InputField("Caution", text: $viewModel.cautionInput, configuration: .inputFieldConfiguration(valueType: .decimal))
            InputMessage()
        }
        .validated(by: viewModel.validateCaution, status: $viewModel.cautionInputResult)
    }
    
    var warningInput: some View {
        VStack(alignment: .leading) {
            Text("Warning Input")
                .fontStyle(theme.font.caption1)
            InputField("Warning", text: $viewModel.warningInput, configuration: .inputFieldConfiguration(valueType: .decimal))
            InputMessage()
        }
        .validated(by: viewModel.validateWarning, status: $viewModel.warningInputResult)
    }
    
    var optionalSelectInput: some View {
        VStack(alignment: .leading) {
            Text("Select Value (Optional)")
                .fontStyle(theme.font.caption1)
            OptionalMenuField(selection: $viewModel.optionalSelectionInput,
                      options: ViewModel.SelectionInputTypes.allCases, placeholder: "Select value placeholder text")
        }
    }
    
    var mandatorySelectInput: some View {
        VStack(alignment: .leading) {
            Text("Select Value (Mandatory)")
                .fontStyle(theme.font.caption1)
            MenuField(selection: $viewModel.selectionInput,
                      options: ViewModel.SelectionInputTypes.allCases)
        }
    }
}
