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
    @ObservedObject var viewModel = DemonstrationViewModel()
    var body: some View {



        ScrollView {
            VStack {

                HStack {
                    InputField(text: $viewModel.kgInput,
                               placeholder: viewModel.kgHint,
                               bottomLabelConfig: BottomLabelConfig("Kilograms"),
                               filter: .integerOnly
                               )
                        .textFieldStyle(.default)


                    Image(systemName: "arrow.left.arrow.right.square")
                    



                    InputField(text: $viewModel.lbsInput,
                               placeholder: viewModel.lbHint,
                               bottomLabelConfig: BottomLabelConfig("Pounds"),
                               filter: .integerOnly)
                        .textFieldStyle(.default)

                }


                }

            }
            .background(theme.color.background)
            .navigationBarTitle("Unit Converter")
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

