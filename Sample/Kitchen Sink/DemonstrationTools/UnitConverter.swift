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
    @ObservedObject var demonstrationVM = UnitConverterViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: theme.padding.grid4x) {
                weightConverterView
                pressureConverterView
                lengthConverterView
                airspeedConverterView
            }
            .padding([.all], theme.padding.grid3x)
        }
        .background(theme.color.background)
        .navigationBarTitle(demonstrationVM.naivgationBarTitle)
    }

    var lengthConverterView: some View {
        VStack {
            HeadingView(
                title: demonstrationVM.adjustableConversionTitle,
                subTitle: demonstrationVM.adjustableConversionSubTitle)
            lengthInput
                .padding([.top], theme.padding.grid2x)
            calculationResult
        }
        .padding([.all], theme.padding.grid3x)
        .cardStyle(theme.cards.filled)
    }
    
    var weightConverterView: some View {
        VStack {
            HeadingView(
                title: demonstrationVM.weightTitle,
                subTitle: demonstrationVM.weightSubtitle)

            HStack(alignment: .top, spacing: theme.padding.grid1x) {
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
                    .padding([.top], theme.padding.grid0_5x)
            }
            .padding([.top], theme.padding.grid2x)
        }
        .padding([.all], theme.padding.grid3x)
        .cardStyle(theme.cards.filled)
    }
    
    var airspeedConverterView: some View {
        VStack {
            HeadingView(
                title: demonstrationVM.airspeedConverterTitle,
                subTitle: demonstrationVM.airspeedConverterSubTitle)
            
            HStack(alignment: .top) {
                InputField(text: $demonstrationVM.airspeedTemperature,
                           placeholder: demonstrationVM.airspeedOATLabel,
                           bottomLabelConfig: demonstrationVM.airspeedTemperatureBottomConfig,
                           filter: .doubleOnly)
                .keyboardType(.numberPad)
                .textFieldStyle(demonstrationVM.airspeedTemperatureTextFieldStyle)
                .padding([.trailing], theme.padding.grid2x)

                MenuField(selection: $demonstrationVM.airspeedTemperatureType,
                          options: TemperatureType.allCases)
                .menuFieldStyle(.default)
                .frame(width: 260)
            }
            .padding([.top], theme.padding.grid2x)
            
            HStack {
                InputField(text: $demonstrationVM.airspeedInputValue,
                           placeholder: demonstrationVM.airspeedInputPlaceholder,
                           filter: .doubleOnly)
                .keyboardType(.numberPad)
                .textFieldStyle(.default)
                .padding([.trailing], theme.padding.grid2x)

                MenuField(selection: $demonstrationVM.airspeedInputSelection,
                          options: AirspeedType.allCases)
                .menuFieldStyle(.default)
                .frame(width: 260)
            }
            .padding([.top], theme.padding.grid1x)
            
            Button(demonstrationVM.convert,
                   action: { demonstrationVM.convertAirspeed() })
            .buttonStyle(.filled)
            .padding([.vertical], theme.padding.grid1x)
            
            InputField(text: $demonstrationVM.airspeedOutputValue,
                       placeholder: demonstrationVM.airspeedOutputPlaceholder)
            .textFieldStyle(.advisory)
        }
        .padding([.all], theme.padding.grid3x)
        .cardStyle(theme.cards.filled)
    }
    
    var pressureConverterView: some View {
        VStack {
            HeadingView(
                title: demonstrationVM.pressureConverterTitle,
                subTitle: demonstrationVM.pressureConverterSubTitle)
            
            HStack(alignment: .top, spacing: theme.padding.grid1x) {
                InputField(text: $demonstrationVM.pressureConversionInput,
                           placeholder: demonstrationVM.pressureConversionInputPlaceholder,
                           bottomLabelConfig: BottomLabelConfig(demonstrationVM.pressureInputBottomLabel),
                           filter: .doubleOnly)
                .keyboardType(.numberPad)
                .textFieldStyle(.default)
                
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        demonstrationVM.swapPressureFields()
                    }
                } label: {
                    Image(systemName: "arrow.left.arrow.right")
                }.buttonStyle(.tonalIcon)
                    .padding([.vertical], theme.padding.grid0_5x)
                
                InputField(text: $demonstrationVM.pressureConversionOutput,
                           placeholder: demonstrationVM.pressureConversionOutputPlaceholder,
                           bottomLabelConfig: BottomLabelConfig(demonstrationVM.pressureOutputBottomLabel))
                .textFieldStyle(.advisory)
                
                Button(demonstrationVM.convert,
                       action: {demonstrationVM.convertPressure()})
                .buttonStyle(.filled)
                .padding([.bottom], theme.padding.grid2x)
            }
            .padding([.top], theme.padding.grid2x)
        }
        .padding([.all], theme.padding.grid3x)
        .cardStyle(theme.cards.filled)
    }

    var calculationResult: some View {
        HStack {
            InputField(text: $demonstrationVM.outputValue, placeholder: demonstrationVM.calculatedField)
                .textFieldStyle(.advisory)
                .padding([.trailing], theme.padding.grid2x)

            MenuField(selection: $demonstrationVM.boundSelectionOutput,
                      options: LengthType.allCases)
            .menuFieldStyle(.default)
            .frame(width: 260)
        }
        .padding([.bottom], theme.padding.grid2x)
    }

    var lengthInput: some View {
        HStack {
            InputField(text: $demonstrationVM.inputValue,
                       placeholder: demonstrationVM.lengthPalceholder,
                       filter: .doubleOnly)
            .keyboardType(.numberPad)
            .textFieldStyle(.default)
            .padding([.trailing], theme.padding.grid2x)

            MenuField(selection: $demonstrationVM.boundSelectionInput,
                      options: LengthType.allCases)
            .menuFieldStyle(.default)
            .frame(width: 260)
        }
        .padding([.bottom], theme.padding.grid1x)
    }

    var kgInputField: some View {
        InputField(text: $demonstrationVM.kgInputString,
                   placeholder: demonstrationVM.kgHint,
                   bottomLabelConfig: BottomLabelConfig(demonstrationVM.bottomKgLabel),
                   formatter: { typedString in
            guard let decimalValue = Decimal(string: typedString) else { return typedString }
            return demonstrationVM.toString2DP(value: decimalValue)
        }, filter: .doubleOnly)
        .keyboardType(.numberPad)
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
        .keyboardType(.numberPad)
        .textFieldStyle(demonstrationVM.lbInputFieldStyle ?? DefaultTextFieldStyle.default)
    }

    var swapButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.5)) {
                swapFields()
            }
        } label: {
            Image(systemName: "arrow.left.arrow.right")
        }.buttonStyle(.tonalIcon)
            .padding([.vertical], theme.padding.grid0_5x)
    }

    var convertButton1: some View {
        Button(demonstrationVM.convert,
               action: {demonstrationVM.convertStaticUnits()})
        .buttonStyle(.filled)
        .padding([.bottom], theme.padding.grid2x)
    }

//    var convertButton2: some View {
//        Button(demonstrationVM.convert,
//               action: {demonstrationVM.runLengthConversion()})
//        .buttonStyle(.filled)
//    }

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
