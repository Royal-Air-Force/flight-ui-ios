import SwiftUI
import FlightUI

struct Tab1: View {
    @EnvironmentObject var theme: Theme
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            tabHeader
                .padding([.top, .bottom], theme.large)
            
            textualInput
                .padding([.bottom], theme.large)
            
            selectionInput
                .padding([.bottom], theme.large)

            buttonsInput
                .padding([.top, .bottom], theme.large)

            Spacer()
        }
        .padding([.leading, .trailing], theme.xxlarge)
        .background(Color.flightBlack)
        .alert("Reset Alert", isPresented: $viewModel.isShowingResetAlert) {
            Button("Reset Inputs", role: .destructive, action: viewModel.reset)
        } message: {
            Text("Message content")
        }
    }
    
    @ViewBuilder
    var tabHeader: some View {
        HStack {
            Text("Inputs & Selectors")
                .typography(.h1)
            Spacer()
            Button("Reset", action: { viewModel.isShowingResetAlert.toggle() })
                .buttonStyle(.tertiary)
        }
    }

    var textualInput: some View {
        GridRow(alignment: .top) {
            VStack(alignment: .leading) {
                Text("Full Length Textual Input")
                    .typography(.caption)
                InputField("Select", text: $viewModel.textualInput)
            }
            .gridCellColumns(2)

            VStack(alignment: .leading) {
                Text("Numerical Input with Validation")
                    .typography(.caption)
                InputField("0 - 100", text: $viewModel.numericalInput, configuration: .inputFieldConfiguration(valueType: .decimal))
                InputMessage()
            }
            .validated(by: viewModel.validateNumericalInput, status: $viewModel.numericalInputResult)
        }
    }
    
    var selectionInput: some View {
        GridRow(alignment: .top) {
            VStack(alignment: .leading) {
                Text("Select Value (Mandatory)")
                    .typography(.caption)
                MenuField(selection: $viewModel.selectionInput,
                          options: ViewModel.SelectionInputTypes.allCases)
                .padding([.bottom], theme.large )
                
                Text("Select Value (Optional)")
                    .typography(.caption)
                OptionalMenuField(selection: $viewModel.optionalSelectionInput,
                          options: ViewModel.SelectionInputTypes.allCases, placeholder: "Select value placeholder text")
            }
        }
    }
    
    var buttonsInput: some View {
        HStack {
            Button("Primary", action: {})
                .buttonStyle(.primary)
            Spacer()
            Button("Secondary", action: {})
                .buttonStyle(.secondary)
            Spacer()
            Button("Tertiary", action: {})
                .buttonStyle(.tertiary)
        }
    }
}


struct Tab1_Previews: PreviewProvider {
    static var previews: some View {
        Tab1()
            .environmentObject(Theme())
        
    }
}
