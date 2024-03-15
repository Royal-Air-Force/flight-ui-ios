//
//  DemonstrationViewModel.swift
//  Kitchen Sink
//
//  Created by Jake Dove on 11/03/2024.
//

import Foundation
import Combine
import FlightUI
import SwiftUI

 class DemonstrationViewModel : ObservableObject {

    @Published var kgInputString: String = ""
    @Published var lbsInputString: String = ""
    @Published var emptyFields = false
    @Published var inputValue: String = ""
    @Published var inputUnit: lengthType = .feet
    @Published var outputUnit: lengthType = .metres
    @Published var outputValue: String = ""
    @Published var boundSelectionInput : lengthType? = .feet
    @Published var boundSelectionOutput : lengthType? = .metres

    private let feetToMetresConversionRate = 3.28084
    private let metresToFeetConversionRate = 0.3048
    private let kgToLbConversionRate = 2.205

    let adjustableConversionTitle = "Adjustable conversion"
    let adjustableConversionSubTitle = "Example of conversion with Menu Picker"
    let weightTitle = "Kilograms to Pounds"
    let weightSubtitle = "Example of fixed weight conversion with reversable function"
    let naivgationBarTitle = "Unit Converter"
    let calculatedField = "Calculated result"
    let convert = "Convert"

    let lengthPalceholder = "Enter Length"
    let bottomKgLabel = "Kilograms"
    let bottomlbLabel = "Pounds"
    let kgHint = "Enter Kgs"
    let lbHint = "Enter Lgs"

    func runLengthConversion() {
        let inputAsDouble = toDouble(string: inputValue)
        let inputUnitInMetres = convertToMeters(value: inputAsDouble, from: boundSelectionInput ?? .metres )
        let outputInMetres = convertFromMeters(value: inputUnitInMetres, from: boundSelectionOutput ?? .metres )
        outputValue = toString2DP(value: outputInMetres)
    }

    func convertToMeters(value: Double, from unit: lengthType) -> Double {
           switch unit {

           case .feet:
               return value / feetToMetresConversionRate
           case .metres:
               return value
           }
       }

    func convertFromMeters(value: Double, from unit: lengthType) -> Double {
        switch unit {
        case .feet:
            return value / metresToFeetConversionRate
        case .metres:
            return value
        }
    }

    func toDouble(string: String) -> Double {
        return Double(string) ?? 0.0
    }

    func toString2DP(value: Double) -> String {
        return String (format: "%.2f", value)
    }

    func convertKgsToLbs(kgs: Double) -> Double {
        return (kgs * kgToLbConversionRate)
    }

    func convertLbsToKg(lbs: Double) -> Double {
        return (lbs / kgToLbConversionRate)
    }

    func fieldsAreEmpty() -> Bool {
        emptyFields = kgInputString.isEmpty && lbsInputString.isEmpty
        return emptyFields
    }

    func runWeightConversion(kgToLbConversion: Bool) {
        if (kgToLbConversion) {
            let lbsDouble = toDouble(string: kgInputString)
            let convertedValue = convertKgsToLbs(kgs: lbsDouble)
            lbsInputString = toString2DP(value: convertedValue)
        }else {
            let kgDouble = toDouble(string: lbsInputString)
            var convertedValue = convertLbsToKg(lbs: kgDouble)
            kgInputString = toString2DP(value: convertedValue)
        }
    }

    enum lengthType: String, CaseIterable, CustomStringConvertible {
        case feet = "Feet"
        case metres = "Metres"
        var description: String {
            return rawValue
        }
    }
}
