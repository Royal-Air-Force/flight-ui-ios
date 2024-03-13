//
//  UnitConverter.swift
//  Kitchen Sink
//
//  Created by Jake Dove on 11/03/2024.
//

import Foundation
import SwiftUI
import FlightUI

struct UnitConverter: View {
    @EnvironmentObject var theme: Theme
    @StateObject var themeManager = ThemeManager(current: .dark)
    @ObservedObject var viewModel = DemonstrationViewModel()
    @State private var isSwapped = false

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    if (isSwapped) {
                        createKgInputField()
                        createSwapButton()
                        createLbInputField()
                    } else {
                        createLbInputField()
                        createSwapButton()
                        createKgInputField()
                    }
                    createConvertButton()
                }

                .padding(themeManager.current.padding.grid4x)
            }
        }
        .background(theme.color.background)
        .navigationBarTitle("Unit Converter")
    }

    func createKgInputField() -> some View {
        InputField(text: $viewModel.kgInputString,
                   placeholder: viewModel.kgHint,
                   bottomLabelConfig: BottomLabelConfig("Kilograms"),
                   filter: .doubleOnly)
        .textFieldStyle(.default)
    }

    func createLbInputField() -> some View {
        InputField(text: $viewModel.lbsInputString,
                   placeholder: viewModel.lbHint,
                   bottomLabelConfig: BottomLabelConfig("Pounds"),
                   filter: .doubleOnly)
        .textFieldStyle(.default)
    }

    func createSwapButton() -> some View {
        Button(action:  {
            withAnimation(.easeInOut(duration: 0.5)) {
                swapFields()
            }
        }) {
            Image(systemName: "arrow.left.arrow.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(theme.color.nominal)
                .padding([.bottom],theme.padding.grid2x)
        }
    }

    func swapFields() {
        isSwapped.toggle()
    }

    func createConvertButton() -> some View {
        Button(action: {
            viewModel.runWeightConversion(isSwapped: isSwapped)
        }) {
            Text("Convert")
        }
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


