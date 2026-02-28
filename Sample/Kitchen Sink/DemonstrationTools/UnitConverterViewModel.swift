import Foundation
import Combine
import FlightUI
import SwiftUI

@Observable
class UnitConverterViewModel {

    var kgInputString: String = ""
    var lbsInputString: String = ""
    var inputValue: String = ""
    var outputValue: String = ""
    var boundSelectionInput: LengthType? = .feet
    var boundSelectionOutput: LengthType? = .metres
    var weightValuesSwapped = false
    var emptyFields = false
    var kgInputFieldStyle: InputFieldStyle? = InputFieldStyle(.default)
    var lbInputFieldStyle: InputFieldStyle? = InputFieldStyle(.default)

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
    let lbHint = "Enter Lbs"

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
        let roundingHandler = NSDecimalNumberHandler(
            roundingMode: .plain,
            scale: 2,
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: false
        )
        return NSDecimalNumber(decimal: value).rounding(accordingToBehavior: roundingHandler)
    }

    func convertKgsToLbs(kgs: Decimal) -> Decimal {
        return (kgs * kgToLbConversionRate)
    }

    func convertLbsToKg(lbs: Decimal) -> Decimal {
        return (lbs / kgToLbConversionRate)
    }

    func checkForEmptyFields() {

        if weightValuesSwapped {
            emptyFields = kgInputString.isEmpty
            if emptyFields { // if the field is empty, adjust the style of the empty field & reset the converted display
                kgInputFieldStyle = InputFieldStyle(.caution)
                lbsInputString = ""
            } else {
                kgInputFieldStyle = InputFieldStyle(.default)
                lbInputFieldStyle = InputFieldStyle(.advisory)
            }
        } else {
            emptyFields = lbsInputString.isEmpty
            if emptyFields { // if the field is empty, adjust the style of the empty field & reset the converted display
                lbInputFieldStyle = InputFieldStyle(.caution)
                kgInputString = ""
            } else {
                lbInputFieldStyle = InputFieldStyle(.default)
                kgInputFieldStyle = InputFieldStyle(.advisory)
            }
        }
    }

    func convertStaticUnits() {
        checkForEmptyFields()
        if emptyFields {
            runWeightConversion()
        }
    }

    func runWeightConversion(kgToLbConversion: Bool = false) {
        if weightValuesSwapped || kgToLbConversion {
            let lbsDecimal = toDecimal(string: kgInputString)
            let convertedValue = convertKgsToLbs(kgs: lbsDecimal)
            lbsInputString = toString2DP(value: convertedValue)
        } else {
            let kgDecimal = toDecimal(string: lbsInputString)
            let convertedValue = convertLbsToKg(lbs: kgDecimal)
            kgInputString = toString2DP(value: convertedValue)
        }
    }

    func fieldsAreEmpty() -> Bool {
        return kgInputString.isEmpty && lbsInputString.isEmpty
    }

    enum LengthType: String, CaseIterable, CustomStringConvertible {
        case feet = "Feet"
        case metres = "Metres"
        var description: String {
            return rawValue
        }
    }
}
