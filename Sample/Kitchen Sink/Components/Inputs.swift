//
//  Inputs.swift
//  Flight UI - Kitchen Sink Sample
//
//  Created by Appivate 2023
//

import SwiftUI
import FlightUI

struct Inputs: View {
    @EnvironmentObject var theme: Theme
    @StateObject private var viewModel = InputsViewModel()

    var body: some View {
        ScrollView {
            VStack {
                generalInput
                advisoryInput
                stateInputs
                labelInput
                managedInput
                selectionInput
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

            HStack(alignment: .top) {
                InputField(text: $viewModel.nominalStateInput, placeholder: "Nominal", bottomLabelConfig: viewModel.nominalAdvisory())
                    .textFieldStyle(InputFieldStyle(viewModel.nominalState()))

                InputField(text: $viewModel.cautionStateInput, placeholder: "Caution", bottomLabelConfig: viewModel.cautionAdvisory())
                    .textFieldStyle(InputFieldStyle(viewModel.cautionState()))

                InputField(text: $viewModel.warningStateInput, placeholder: "Warning", bottomLabelConfig: viewModel.warningAdvisory())
                    .textFieldStyle(InputFieldStyle(viewModel.warningState()))
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
                InputField(text: $viewModel.topLabel, placeholder: "Top Label", topLabel: "Top Label")
                    .textFieldStyle(.default)

                InputField(text: $viewModel.bottomLabel, placeholder: "Bottom Label", topLabelSpacer: true, bottomLabelConfig: BottomLabelConfig("Bottom Label information goes here"))
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
                subTitle: "Input fields that provide some additional level of management including; formatting on focus change, filtering allowed input, and debounce functionality")

            HStack(alignment: .top) {
                InputField(text: $viewModel.formatInput, placeholder: "Formatter", bottomLabelConfig: BottomLabelConfig("Formats numbers to 2dp"), formatter: { typedString in
                        guard let doubleValue = Double(typedString) else { return typedString }
                        return String(format: "%.2f", doubleValue)
                })
                .textFieldStyle(.default)

                InputField(text: $viewModel.keyboardInput, placeholder: "Filter", bottomLabelConfig: BottomLabelConfig("Filters out non-digit characters"), filter: .integerOnly)
                    .textFieldStyle(.default)

                InputField(text: $viewModel.debounceInput, placeholder: "Debounce", bottomLabelConfig: BottomLabelConfig(viewModel.debounceAdvisoryLabel))
                    .textFieldStyle(.default)
                    .onChange(of: viewModel.debounceInput) { _ in
                        viewModel.debounceAdvisoryLabel = InputsViewModel.defaultDebounceAdvisoryLabel
                    }
                    .onDebounce(of: viewModel.debounceInput, duration: .seconds(2)) { debouncedValue in
                        if debouncedValue.isEmpty {
                            viewModel.debounceAdvisoryLabel = InputsViewModel.defaultDebounceAdvisoryLabel
                        } else {
                            viewModel.debounceAdvisoryLabel = debouncedValue
                        }
                    }
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

            HStack {
                MenuField(selection: $viewModel.boundSelectionInput,
                             options: InputsViewModel.BoundSelectionTypes.allCases,
                             placeholder: "Bound Selection Input")
                .menuFieldStyle(MenuFieldStyle(viewModel.boundSelectionState()))

                UnboundMenuField(selection: $viewModel.unboundSelectionInput,
                                 options: InputsViewModel.UnboundDefaultSelectionTypes.allCases,
                                 placeholder: "Unbound Selection Input")
                .menuFieldStyle(MenuFieldStyle(viewModel.unboundSelectionState()))
            }
            .padding(.top, theme.padding.grid2x)
        }
        .padding(.bottom, theme.padding.grid4x)
    }
}

#if DEBUG

struct Inputs_Previews: PreviewProvider {
    static var theme: Theme = Theme(baseScheme: .dark)

    static var previews: some View {
        Inputs()
            .environmentObject(theme)
            .previewDisplayName("Input Samples")
            .preferredColorScheme(theme.baseScheme)
    }
}

#endif
