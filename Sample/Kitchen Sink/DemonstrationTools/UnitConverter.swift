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
    @StateObject var themeManager = ThemeManager(current: .dark)
    @ObservedObject var demonstrationVM = UnitConverterViewModel()
    @State private var weightValuesSwapped = false

    var body: some View {
        ScrollView {

            VStack {
                HeadingView(
                    title: demonstrationVM.weightTitle,
                    subTitle: demonstrationVM.weightSubtitle)

                HStack {
                    if  weightValuesSwapped {
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
            .padding([.top], themeManager.current.padding.grid2x)

            HStack {
                VStack {
                    HeadingView(
                        title: demonstrationVM.adjustableConversionTitle,
                        subTitle: demonstrationVM.adjustableConversionSubTitle)
                    HStack {
                        lengthInput
                        lengthInputUnitPicker
                    }

                    HStack {
                        calculationResult
                        lengthOutputUnitPicker
                    }
                }
                VStack {
                    Spacer()
                    convertButton2
                        .padding([.bottom], themeManager.current.padding.grid2x)
                }
            }
            .padding([.top], themeManager.current.padding.grid2x)
        }
        .padding([.leading, .trailing], themeManager.current.padding.grid2x)
        .background(theme.color.background)
        .navigationBarTitle(demonstrationVM.naivgationBarTitle)
    }

    var calculationResult: some View {
        InputField(text: $demonstrationVM.outputValue, placeholder: demonstrationVM.calculatedField)
            .textFieldStyle(.advisory)
            .padding([.bottom], themeManager.current.padding.grid2x)
    }

    var lengthInput: some View {
        InputField(text: $demonstrationVM.inputValue,
                   placeholder: demonstrationVM.lengthPalceholder,
                   bottomLabelConfig: BottomLabelConfig(""),
                   filter: .doubleOnly)
        .textFieldStyle(.default)
    }

    var lengthInputUnitPicker: some View {
        MenuField(selection: $demonstrationVM.boundSelectionInput,
                  options: UnitConverterViewModel.LengthType.allCases,
                  placeholder: "")
        .menuFieldStyle(.default)
        .padding([.bottom], themeManager.current.padding.grid2x)
    }

    var lengthOutputUnitPicker: some View {
        MenuField(selection: $demonstrationVM.boundSelectionOutput,
                  options: UnitConverterViewModel.LengthType.allCases,
                  placeholder: "")
        .menuFieldStyle(.default)
        .padding([.bottom], themeManager.current.padding.grid2x)
    }

    var kgInputField: some View {
        InputField(text: $demonstrationVM.kgInputString,
                   placeholder: demonstrationVM.kgHint,
                   bottomLabelConfig: BottomLabelConfig(demonstrationVM.bottomKgLabel),
                   formatter: { typedString in
            guard let decimalValue = Decimal(string: typedString) else { return typedString }
            return demonstrationVM.toString2DP(value: decimalValue)
        }, filter: .doubleOnly)
        .textFieldStyle(demonstrationVM.emptyFields ? DefaultTextFieldStyle.caution : DefaultTextFieldStyle.default)
    }

    var lbInputField: some View {
        InputField(text: $demonstrationVM.lbsInputString,
                   placeholder: demonstrationVM.lbHint,
                   bottomLabelConfig: BottomLabelConfig(demonstrationVM.bottomlbLabel),
                   formatter: { typedString in
            guard let decimalValue = Decimal(string: typedString) else { return typedString }
            return demonstrationVM.toString2DP(value: decimalValue)
        }, filter: .doubleOnly)
        .textFieldStyle(demonstrationVM.emptyFields ? DefaultTextFieldStyle.caution : DefaultTextFieldStyle.default)
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
                .frame(width: 40, height: 40)
                .foregroundColor(theme.color.nominal)
                .padding([.bottom], theme.padding.grid2x)
        })
    }

    var convertButton1: some View {
        Button(action: {
            convertStaticUnits()
        })
        {
            Text(demonstrationVM.convert)
                .padding([.bottom], theme.padding.grid2x)
        }
        .buttonStyle(.text)
    }

    var convertButton2: some View {
        Button(action: {
            runLengthConversion()
        }){
            Text(demonstrationVM.convert)
                .padding([.bottom], theme.padding.grid2x)
        }
        .buttonStyle(.text)
    }

    func convertStaticUnits() {
        if !demonstrationVM.fieldsAreEmpty() {
            demonstrationVM.runWeightConversion(kgToLbConversion: weightValuesSwapped)
        }
    }

    func runLengthConversion() {
        demonstrationVM.runLengthConversion()
    }

    func swapFields() {
        weightValuesSwapped.toggle()
        convertStaticUnits()
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
