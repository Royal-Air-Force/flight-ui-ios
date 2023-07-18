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

                errorInput
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

    var errorInput: some View {
        VStack(alignment: .leading) {
            Text("Error Input")
                .fontStyle(theme.font.caption1)
            InputField("Error", text: $viewModel.errorInput, configuration: .inputFieldConfiguration(valueType: .decimal))
            InputMessage()
        }
        .validated(by: viewModel.validateError, status: $viewModel.errorInputResult)
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
