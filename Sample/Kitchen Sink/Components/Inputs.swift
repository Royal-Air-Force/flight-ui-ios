import SwiftUI
import FlightUI

// TODO: Remove InputField and replace with WrappedTextField (comment out validation for now)
// TODO: Fix spacing for top and advisory labels
// TODO: Debounce?
// TODO: Advisory Labels in sync with state changes (i.e. caution -> nominal)
// TODO: Selection Input
// TODO: Functional Inputs
// TODO: Validation?
// TODO: iPad Numeric Keyboard

struct Inputs: View {
    @EnvironmentObject var theme: Theme
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        ScrollView {
            VStack {
                generalInput
                advisoryInput
                stateInputs
                labelInput
//                inputWithIcons

            }
            .padding(.horizontal, theme.padding.grid3x)
        }
        .background(theme.color.background)
        .navigationBarTitle("Inputs")
    }

    var generalInput: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "General Input",
                subTitle: "The default input field provides styling for a common input field, supporting disabled and hint states")

            HStack {
                InputField(text: $viewModel.generalDisabled, placeholder: "Disabled")
                    .textFieldStyle(.default)
                    .disabled(true)

                InputField(text: $viewModel.generalHint, placeholder: "Hint")
                    .textFieldStyle(.default)

                InputField(text: $viewModel.generalActive, placeholder: "General")
                    .textFieldStyle(.default)
            }
            .padding(.top, theme.padding.grid2x)
        }
        .padding(.bottom, theme.padding.grid4x)
    }

    var advisoryInput: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "Advisory Text",
                subTitle: "A specific component used for displaying text with a high visual impact but that the user cannot interact with, typically this is used for results of calculations or tasks")

            InputField(text: $viewModel.advisoryText, placeholder: "Advisory")
                .textFieldStyle(.advisory)
                .frame(width: 240)
                .padding(.top, theme.padding.grid2x)
        }
        .padding(.bottom, theme.padding.grid4x)
    }

    var stateInputs: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "State Input",
                subTitle: "An extension on the General input field which supports setting a contextual state, changing the visual to one of a nominal, caution, and warning state. " +
                    "Clear the fields to show the default state.")

            HStack {
                InputField(text: $viewModel.nominalState, placeholder: "Nominal", advisoryLabel: AdvisoryLabel("Extra Info"))
                    .textFieldStyle(InputFieldStyle(viewModel.nominalState.isEmpty ? .default : .nominal))

                InputField(text: $viewModel.cautionState, placeholder: "Caution", advisoryLabel: AdvisoryLabel("Extra Info", state: .caution))
                    .textFieldStyle(InputFieldStyle(viewModel.cautionState.isEmpty ? .default : .caution))

                InputField(text: $viewModel.warningState, placeholder: "Warning", advisoryLabel: AdvisoryLabel("Extra Info", state: .warning))
                    .textFieldStyle(InputFieldStyle(viewModel.warningState.isEmpty ? .default : .warning))
            }
            .padding(.top, theme.padding.grid2x)
        }
        .padding(.bottom, theme.padding.grid4x)
    }

    var labelInput: some View {
        VStack {
            HeadingView(
                title: "Label Input",
                subTitle: "Provides input fields that can support labels above and below the field itself, " +
                    "useful for providing supporting information that does not hide when the user types in the field")

            HStack(alignment: .center) {
                InputField(text: $viewModel.topLabel, placeholder: "Top Label", topLabel: "Top Label", advisoryLabelSpacer: true)
                    .textFieldStyle(.default)

                InputField(text: $viewModel.advisoryLabel, placeholder: "Advisory Label", topLabelSpacer: true, advisoryLabel: AdvisoryLabel("Advisory information goes here"))
                    .textFieldStyle(.default)
            }
            .padding(.top, theme.padding.grid2x)
        }
        .padding(.bottom, theme.padding.grid4x)
    }

    var inputWithIcons: some View {
        VStack {
            HeadingView(
                title: "Input with Icons",
                subTitle: "Icons are supported within text fields, either at the start, end, or on both sides of the input fields")

            HStack {
                InputField(text: $viewModel.topLabel, placeholder: "Leading Icon")
                    .textFieldStyle(.default)

                InputField(text: $viewModel.advisoryLabel, placeholder: "Trailing Icon")
                    .textFieldStyle(.default)

                InputField(text: $viewModel.advisoryLabel, placeholder: "Dual Icons")
                    .textFieldStyle(.default)
            }
            .padding(.top, theme.padding.grid2x)
        }
        .padding(.bottom, theme.padding.grid4x)
    }

    var selectionInput: some View {
        VStack {
            HeadingView(
                title: "Selection Input",
                subTitle: "Providing either a bound or unbound set of options for user selection and input")

        }
        .padding(.bottom, theme.padding.grid4x)
    }

//    var textInput: some View {
//        VStack(alignment: .leading) {
//            Text("Full Length Textual Input")
//                .fontStyle(theme.font.caption1)
//            InputField("Select", text: $viewModel.textualInput)
//        }
//    }
//
//    var numberInput: some View {
//        VStack(alignment: .leading) {
//            Text("Numerical Input with Validation")
//                .fontStyle(theme.font.caption1)
//            InputField("0 - 100", text: $viewModel.numericalInput, configuration: .inputFieldConfiguration(valueType: .decimal))
//            InputMessage()
//        }
//    }
//
//    var advisoryInput: some View {
//        VStack(alignment: .leading) {
//            Text("Advisory Input")
//                .fontStyle(theme.font.caption1)
//            InputField("Advisory", text: $viewModel.advisoryInput, configuration: .inputFieldConfiguration(valueType: .decimal))
//            InputMessage()
//        }
//        .validated(by: viewModel.validateAdvisory, status: $viewModel.advisoryInputResult)
//    }
//
//    var cautionInput: some View {
//        VStack(alignment: .leading) {
//            Text("Caution Input")
//                .fontStyle(theme.font.caption1)
//            InputField("Caution", text: $viewModel.cautionInput, configuration: .inputFieldConfiguration(valueType: .decimal))
//            InputMessage()
//        }
//        .validated(by: viewModel.validateCaution, status: $viewModel.cautionInputResult)
//    }
//
//    var warningInput: some View {
//        VStack(alignment: .leading) {
//            Text("Warning Input")
//                .fontStyle(theme.font.caption1)
//            InputField("Warning", text: $viewModel.warningInput, configuration: .inputFieldConfiguration(valueType: .decimal))
//            InputMessage()
//        }
//        .validated(by: viewModel.validateWarning, status: $viewModel.warningInputResult)
//    }
//
//    var optionalSelectInput: some View {
//        VStack(alignment: .leading) {
//            Text("Select Value (Optional)")
//                .fontStyle(theme.font.caption1)
//            OptionalMenuField(selection: $viewModel.optionalSelectionInput,
//                      options: ViewModel.SelectionInputTypes.allCases, placeholder: "Select value placeholder text")
//        }
//    }
//
//    var mandatorySelectInput: some View {
//        VStack(alignment: .leading) {
//            Text("Select Value (Mandatory)")
//                .fontStyle(theme.font.caption1)
//            MenuField(selection: $viewModel.selectionInput,
//                      options: ViewModel.SelectionInputTypes.allCases)
//        }
//    }
}
