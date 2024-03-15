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
    @Published var inputUnit: LengthType = .feet
    @Published var outputUnit: LengthType = .metres
    @Published var outputValue: String = ""
    @Published var boundSelectionInput : LengthType? = .feet
    @Published var boundSelectionOutput : LengthType? = .metres

     private let feetToMetresConversionRate: Decimal = 3.28084
     private let metresToFeetConversionRate: Decimal = 0.3048006096
     private let kgToLbConversionRate: Decimal = 2.20462262

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
        let inputDecimal = toDecimal(string: inputValue)
        let inputUnitInMetres = convertToMeters(value: inputDecimal, from: boundSelectionInput ?? .metres )
        let outputInMetres = convertFromMeters(value: inputUnitInMetres, from: boundSelectionOutput ?? .metres )
        outputValue = toString2DP(value: outputInMetres)
    }

    func convertToMeters(value: Decimal, from unit: LengthType) -> Decimal {
           switch unit {

           case .feet:
               return value / feetToMetresConversionRate
           case .metres:
               return value
           }
       }

    func convertFromMeters(value: Decimal, from unit: LengthType) -> Decimal {
        switch unit {
        case .feet:
            return value / metresToFeetConversionRate
        case .metres:
            return value
        }
    }

     func toDecimal(string: String) -> Decimal {
         return Decimal(string: string) ?? 0.0
     }

     func toString2DP(value: Decimal) -> String {
         let formattedValue = getNSDecimalNumber(value: value)
         return String(format: "%.2f", formattedValue.doubleValue)
     }

     func getNSDecimalNumber(value: Decimal) -> NSDecimalNumber {
         return NSDecimalNumber(decimal: value).rounding(accordingToBehavior: NSDecimalNumberHandler(roundingMode: .plain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false))
     }

    func convertKgsToLbs(kgs: Decimal) -> Decimal {
        return (kgs * kgToLbConversionRate)
    }

    func convertLbsToKg(lbs: Decimal) -> Decimal {
        return (lbs / kgToLbConversionRate)
    }

    func fieldsAreEmpty() -> Bool {
        emptyFields = kgInputString.isEmpty && lbsInputString.isEmpty
        return emptyFields
    }

    func runWeightConversion(kgToLbConversion: Bool) {
        if (kgToLbConversion) {
            let lbsDecimal = toDecimal(string: kgInputString)
            let convertedValue = convertKgsToLbs(kgs: lbsDecimal)
            lbsInputString = toString2DP(value: convertedValue)
        }else {
            let kgDecimal = toDecimal(string: lbsInputString)
            var convertedValue = convertLbsToKg(lbs: kgDecimal)
            kgInputString = toString2DP(value: convertedValue)
        }
    }

    enum LengthType: String, CaseIterable, CustomStringConvertible {
        case feet = "Feet"
        case metres = "Metres"
        var description: String {
            return rawValue
        }
    }
}
