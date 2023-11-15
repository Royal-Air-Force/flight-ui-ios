import SwiftUI
import FlightUI

// TODO: Debounce?
// TODO: Advisory Labels in sync with state changes (i.e. caution -> nominal)
// TODO: Selection Input
// TODO: Functional Inputs
// TODO: Validation?
// TODO: iPad Numeric Keyboard
// TODO: Remove comments

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
                managedInput

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
                    .onChange(of: viewModel.generalHint) { newText in
                        print("General hint changed to \(newText)")
                    }

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

            HStack(alignment: .top) {
                InputField(text: $viewModel.topLabel, placeholder: "Top Label", topLabel: "Top Label", advisoryLabelSpacer: true)
                    .textFieldStyle(.default)

                InputField(text: $viewModel.advisoryLabel, placeholder: "Advisory Label", topLabelSpacer: true, advisoryLabel: AdvisoryLabel("Advisory information goes here"))
                    .textFieldStyle(.default)
            }
            .padding(.top, theme.padding.grid2x)
        }
        .padding(.bottom, theme.padding.grid4x)
    }

    var managedInput: some View {
        VStack {
            HeadingView(
                title: "Managed Input",
                subTitle: "Input fields that provide some additional level of management including; real time formatting, debounce functionality, and custom keyboards")

            HStack(alignment: .top) {
                InputField(text: $viewModel.formatInput, placeholder: "Formatter", advisoryLabel: AdvisoryLabel("Formats numbers to 2dp"), formatter: { typedString in
                     guard let doubleValue = Double(typedString) else { return typedString }
                     return String(format: "%.2f", doubleValue)
                })
                .textFieldStyle(.default)

                InputField(text: $viewModel.debounceInput, placeholder: "Debounce", advisoryLabel: AdvisoryLabel(viewModel.debounceAdvisoryLabel))
                    .textFieldStyle(.default)
                    .onChange(of: viewModel.debounceInput) { _ in
                        viewModel.debounceAdvisoryLabel = Inputs.ViewModel.defaultDebounceAdvisoryLabel
                    }
                    .onDebounce(of: viewModel.debounceInput, duration: .seconds(2)) { debouncedValue in
                        if debouncedValue.isEmpty {
                            viewModel.debounceAdvisoryLabel = Inputs.ViewModel.defaultDebounceAdvisoryLabel
                        } else {
                            viewModel.debounceAdvisoryLabel = debouncedValue
                        }
                    }

                // TODO: Custom Keyboard
                InputField(text: $viewModel.keyboardInput, placeholder: "Number Keyboard", advisoryLabel: AdvisoryLabel("Enables iPad numeric keyboard"))
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
