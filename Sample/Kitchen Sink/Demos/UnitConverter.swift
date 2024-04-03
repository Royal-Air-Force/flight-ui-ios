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
    @StateObject var viewModel = UnitConverterViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: theme.padding.grid3x) {
                weightConverterView
                pressureConverterView
                lengthConverterView
                airspeedConverterView
            }
            .padding([.all], theme.padding.grid3x)
        }
        .background(theme.color.background)
        .navigationBarTitle(UnitConverter.screenTitle)
    }
    
    var weightConverterView: some View {
        VStack {
            HeadingView(
                title: UnitConverter.weightTitle,
                subTitle: UnitConverter.weightSubTitle)

            HStack(alignment: .top, spacing: theme.padding.grid1x) {
                InputField(text: $viewModel.weightConversionInput,
                           placeholder: viewModel.weightConversionInputPlaceholder,
                           bottomLabelConfig: BottomLabelConfig(viewModel.weightInputBottomLabel),
                           formatter: { typedString in
                    return viewModel.formatInputValue(value: typedString)
                },
                           filter: .doubleOnly)
                .keyboardType(.numberPad)
                .textFieldStyle(.default)
                
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        viewModel.swapWeightFields()
                    }
                } label: {
                    Image(systemName: "arrow.left.arrow.right")
                }.buttonStyle(.tonalIcon)
                    .padding([.vertical], theme.padding.grid0_5x)

                InputField(text: $viewModel.weightConversionOutput,
                           placeholder: viewModel.weightConversionOutputPlaceholder,
                           bottomLabelConfig: BottomLabelConfig(viewModel.weightOutputBottomLabel))
                .textFieldStyle(.advisory)

                Button(UnitConverter.convertButton,
                       action: {viewModel.convertWeight()})
                .buttonStyle(.filled)
                .padding([.bottom], theme.padding.grid2x)
            }
            .padding([.top], theme.padding.grid2x)
        }
        .padding([.all], theme.padding.grid3x)
        .cardStyle(theme.cards.filled)
    }
    
    var pressureConverterView: some View {
        VStack {
            HeadingView(
                title: UnitConverter.pressureTitle,
                subTitle: UnitConverter.pressureSubTitle)

            HStack(alignment: .top, spacing: theme.padding.grid1x) {
                InputField(text: $viewModel.pressureConversionInput,
                           placeholder: viewModel.pressureConversionInputPlaceholder,
                           bottomLabelConfig: BottomLabelConfig(viewModel.pressureInputBottomLabel),
                           formatter: { typedString in
                    return viewModel.formatInputValue(value: typedString)
                },
                           filter: .doubleOnly)
                .keyboardType(.numberPad)
                .textFieldStyle(.default)
                
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        viewModel.swapPressureFields()
                    }
                } label: {
                    Image(systemName: "arrow.left.arrow.right")
                }.buttonStyle(.tonalIcon)
                    .padding([.vertical], theme.padding.grid0_5x)

                InputField(text: $viewModel.pressureConversionOutput,
                           placeholder: viewModel.pressureConversionOutputPlaceholder,
                           bottomLabelConfig: BottomLabelConfig(viewModel.pressureOutputBottomLabel))
                .textFieldStyle(.advisory)

                Button(UnitConverter.convertButton,
                       action: {viewModel.convertPressure()})
                .buttonStyle(.filled)
                .padding([.bottom], theme.padding.grid2x)
            }
            .padding([.top], theme.padding.grid2x)
        }
        .padding([.all], theme.padding.grid3x)
        .cardStyle(theme.cards.filled)
    }
    
    var lengthConverterView: some View {
        VStack {
            HeadingView(
                title: UnitConverter.lengthTitle,
                subTitle: UnitConverter.lengthSubTitle)
            
            HStack {
                InputField(text: $viewModel.inputValue,
                           placeholder: UnitConverter.lengthHint,
                           bottomLabelConfig: BottomLabelConfig(""),
                           filter: .doubleOnly)
                .textFieldStyle(.default)

                MenuField(selection: $viewModel.boundSelectionInput,
                          options: LengthType.allCases)
                .menuFieldStyle(.default)
                .padding([.bottom], theme.padding.grid2x)
            }
            .padding([.top], theme.padding.grid2x)
            
            HStack {
                InputField(text: $viewModel.outputValue, 
                           placeholder: UnitConverter.lengthResultHint)
                    .textFieldStyle(.advisory)
                    .padding([.bottom], theme.padding.grid2x)

                MenuField(selection: $viewModel.boundSelectionOutput,
                          options: LengthType.allCases)
                .menuFieldStyle(.default)
                .padding([.bottom], theme.padding.grid2x)
            }
            
            Button(UnitConverter.convertButton,
                   action: {viewModel.runLengthConversion()})
            .buttonStyle(.filled)
            .padding([.bottom], theme.padding.grid2x)
        }
        .padding([.all], theme.padding.grid3x)
        .cardStyle(theme.cards.filled)
    }
    
    var airspeedConverterView: some View {
        VStack {
            HeadingView(
                title: UnitConverter.airspeedTitle,
                subTitle: UnitConverter.airspeedSubTitle)
            
            HStack(alignment: .top) {
                InputField(text: $viewModel.airspeedTemperature,
                           placeholder: UnitConverter.airspeedOatHint,
                           bottomLabelConfig: viewModel.airspeedTemperatureBottomConfig,
                           filter: .doubleOnly)
                .keyboardType(.numberPad)
                .textFieldStyle(viewModel.airspeedTemperatureTextFieldStyle)
                .padding([.trailing], theme.padding.grid2x)
                
                MenuField(selection: $viewModel.airspeedTemperatureType,
                          options: TemperatureType.allCases)
                .menuFieldStyle(.default)
                .frame(width: 260)
            }
            .padding([.top], theme.padding.grid2x)
            
            HStack {
                InputField(text: $viewModel.airspeedInputValue,
                           placeholder: viewModel.airspeedInputPlaceholder,
                           filter: .doubleOnly)
                .keyboardType(.numberPad)
                .textFieldStyle(.default)
                .padding([.trailing], theme.padding.grid2x)
                
                MenuField(selection: $viewModel.airspeedInputSelection,
                          options: AirspeedType.allCases)
                .menuFieldStyle(.default)
                .frame(width: 260)
            }
            .padding([.top], theme.padding.grid1x)
            
            Button(UnitConverter.convertButton,
                   action: { viewModel.convertAirspeed() })
            .buttonStyle(.filled)
            .padding([.vertical], theme.padding.grid1x)
            
            InputField(text: $viewModel.airspeedOutputValue,
                       placeholder: viewModel.airspeedOutputPlaceholder)
            .textFieldStyle(.advisory)
        }
        .padding([.all], theme.padding.grid3x)
        .cardStyle(theme.cards.filled)
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
