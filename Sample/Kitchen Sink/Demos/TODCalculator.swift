//
//  TODCalculator.swift
//  flight-ui-ios
//
//  Created by Appivate 2024
//

import SwiftUI
import FlightUI

struct TODCalculator: View {
    
    @EnvironmentObject var theme: Theme
    @StateObject var viewModel: TODCalculatorViewModel
    
    var body: some View {
        VStack {
            Text("Top of Descent Calculator")
        }
        .background(theme.color.background)
        .navigationTitle("Top of Descent Calculator")
    }
    
}
