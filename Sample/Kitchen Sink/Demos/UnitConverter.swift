//
//  Shape+Extensions.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import Foundation
import SwiftUI
import FlightUI

struct UnitConverter: View {
    @EnvironmentObject var theme: Theme
    @StateObject var demonstrationVM = UnitConverterViewModel()

    var body: some View {
        ScrollView {
            VStack {
                HeadingView(
                    title: demonstrationVM.weightTitle,
                    subTitle: demonstrationVM.weightSubtitle)

                HStack {
                    if  demonstrationVM.weightValuesSwapped {
                        kgInputField
                        swapButton
                        lbInputField
                    } else {
                        lbInputField
                        swapButton
                        kgInputField
                    }
                    convertButton1
                }
            }

            headingView
            convertButton2
        }
        .padding([.top], theme.padding.grid2x)
        .padding([.leading, .trailing], theme.padding.grid3x)

        .background(theme.color.background)
        .navigationBarTitle(demonstrationVM.naivgationBarTitle)
    }

    var headingView: some View {
        HStack {
            VStack {
                HeadingView(
                    title: demonstrationVM.adjustableConversionTitle,
                    subTitle: demonstrationVM.adjustableConversionSubTitle)
                lengthInput
                calculationResult
            }
            .padding([.top], theme.padding.grid4x)
        }
    }

    var calculationResult: some View {
        HStack {
            InputField(text: $demonstrationVM.outputValue, placeholder: demonstrationVM.calculatedField)
                .textFieldStyle(.advisory)
                .padding([.bottom], theme.padding.grid2x)

            MenuField(selection: $demonstrationVM.boundSelectionOutput,
                      options: UnitConverterViewModel.LengthType.allCases)
            .menuFieldStyle(.default)
            .padding([.bottom], theme.padding.grid2x)
        }
    }

    var lengthInput: some View {
        HStack {
            InputField(text: $demonstrationVM.inputValue,
                       placeholder: demonstrationVM.lengthPalceholder,
                       bottomLabelConfig: BottomLabelConfig(""),
                       filter: .doubleOnly)
            .textFieldStyle(.default)

            MenuField(selection: $demonstrationVM.boundSelectionInput,
                      options: UnitConverterViewModel.LengthType.allCases)
            .menuFieldStyle(.default)
            .padding([.bottom], theme.padding.grid2x)
        }
    }

    var kgInputField: some View {
        InputField(text: $demonstrationVM.kgInputString,
                   placeholder: demonstrationVM.kgHint,
                   bottomLabelConfig: BottomLabelConfig(demonstrationVM.bottomKgLabel),
                   formatter: { typedString in
            guard let decimalValue = Decimal(string: typedString) else { return typedString }
            return demonstrationVM.toString2DP(value: decimalValue)
        }, filter: .doubleOnly)
        .textFieldStyle(demonstrationVM.kgInputFieldStyle ?? DefaultTextFieldStyle.default)
    }

    var lbInputField: some View {
        InputField(text: $demonstrationVM.lbsInputString,
                   placeholder: demonstrationVM.lbHint,
                   bottomLabelConfig: BottomLabelConfig(demonstrationVM.bottomlbLabel),
                   formatter: { typedString in
            guard let decimalValue = Decimal(string: typedString) else { return typedString }
            return demonstrationVM.toString2DP(value: decimalValue)
        }, filter: .doubleOnly)
        .textFieldStyle(demonstrationVM.lbInputFieldStyle ?? DefaultTextFieldStyle.default)
    }

    var swapButton: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.5)) {
                swapFields()
            }
        }, label: {
            Image(systemName: "arrow.left.arrow.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: theme.size.medium, height: theme.size.medium)
                .foregroundColor(theme.color.nominal)
                .padding([.bottom], theme.padding.grid2x)
        })
    }

    var convertButton1: some View {
        Button(demonstrationVM.convert,
               action: {demonstrationVM.convertStaticUnits()})
        .buttonStyle(.filled)
        .padding([.bottom], theme.padding.grid2x)
    }

    var convertButton2: some View {
        Button(demonstrationVM.convert,
               action: {demonstrationVM.runLengthConversion()})
        .buttonStyle(.filled)
        .padding([.bottom], theme.padding.grid2x)
    }

    func swapFields() {
        demonstrationVM.weightValuesSwapped.toggle()
        demonstrationVM.convertStaticUnits()
    }
}

#if DEBUG

struct UnitConverter_Previews: PreviewProvider {
    static var theme: Theme = Theme(baseScheme: .dark)
    static var previews: some View {
        UnitConverter()
            .environmentObject(theme)
            .previewDisplayName("Unit Converter")
            .preferredColorScheme(theme.baseScheme)
    }
}

#endif
