//
//  UnitConverterViewModel.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import Foundation
import Combine
import FlightUI
import SwiftUI

class UnitConverterViewModel: ObservableObject {

    @Published var kgInputString: String = ""
    @Published var lbsInputString: String = ""
    @Published var inputValue: String = ""
    @Published var outputValue: String = ""
    @Published var boundSelectionInput: LengthType? = .feet
    @Published var boundSelectionOutput: LengthType? = .metres
    @Published var weightValuesSwapped = false
    @Published var emptyFields = false
    @Published var kgInputFieldStyle: InputFieldStyle? = DefaultTextFieldStyle.default
    @Published var lbInputFieldStyle: InputFieldStyle? = DefaultTextFieldStyle.default
    
    @Published var airspeedTemperature: String = ""
    @Published var airspeedTemperatureType: TemperatureType? = .celcius
    
    @Published var airspeedInputValue: String = ""
    @Published var airspeedInputPlaceholder: String = "True Airspeed"
    @Published var airspeedOutputPlaceholder: String = "Mach Result Value"
    @Published var airspeedInputSelection: AirspeedType? = .tas
    @Published var airspeedOutputValue: String = ""
    
    @Published var airspeedTemperatureBottomConfig: BottomLabelConfig = .init(isVisible: false)
    @Published var airspeedTemperatureTextFieldStyle: InputFieldStyle = .init(.default)
    
    @Published var pressureConversionInput: String = ""
    @Published var pressureConversionOutput: String = ""
    @Published var pressureSelectedInputType: PressureType = .inhg
    var pressureConversionInputPlaceholder: String {
        "0.0 \(pressureSelectedInputType)"
    }
    var pressureConversionOutputPlaceholder: String {
        "0.0 \(pressureSelectedInputType.inverse)"
    }
    var pressureInputBottomLabel: String {
        switch pressureSelectedInputType {
        case .inhg:
            return "Inches of Mercury"
        case .mb:
            return "Millibars"
        }
    }
    var pressureOutputBottomLabel: String {
        switch pressureSelectedInputType {
        case .inhg:
            return "Millibars"
        case .mb:
            return "Inches of Mercury"
        }
    }

    private let feetToMetresConversionRate: Decimal = 3.28084
    private let metresToFeetConversionRate: Decimal = 0.3048006096
    private let kgToLbConversionRate: Decimal = 2.20462262

    let adjustableConversionTitle = "Length Converter"
    let adjustableConversionSubTitle = "Example of conversion with Menu Picker for various legnth units"
    let weightTitle = "Weight Converter"
    let weightSubtitle = "Example of fixed weight conversion between Kilograms and Pounds with reversable function"
    let naivgationBarTitle = "Unit Converter"
    let calculatedField = "Calculated result"
    let convert = "Convert"
    
    let airspeedConverterTitle = "Airspeed Converter"
    let airspeedConverterSubTitle = "Example of converting between Mach and TAS with required fields"
    let airspeedOATLabel = "Outside Air Temperature"
    
    let pressureConverterTitle = "Pressure Converter"
    let pressureConverterSubTitle = "Example of pressure conversion between Inches of Mercury and Millibars"

    let lengthPalceholder = "Enter Length"
    let bottomKgLabel = "Kilograms"
    let bottomlbLabel = "Pounds"
    let kgHint = "Enter Kgs"
    let lbHint = "Enter Lbs"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $boundSelectionInput
            .sink { [weak self] inputLengthType in
                self?.runLengthConversion(selectionInput: inputLengthType)
            }
            .store(in: &cancellables)
        $boundSelectionOutput
            .sink { [weak self] outputLengthType in
                self?.runLengthConversion(selectionOutput: outputLengthType)
            }
            .store(in: &cancellables)
        $inputValue
            .sink { [weak self] updatedLength in
                self?.runLengthConversion(inputLengthValue: updatedLength)
            }
            .store(in: &cancellables)
        $airspeedInputSelection
            .sink { [weak self] airspeedSelection in
                switch (airspeedSelection) {
                case .mach:
                    self?.airspeedInputPlaceholder = "Mach Number"
                    self?.airspeedOutputPlaceholder = "TAS Result Value"
                default:
                    self?.airspeedInputPlaceholder = "True Airspeed"
                    self?.airspeedOutputPlaceholder = "Mach Result Value"
                }
            }.store(in: &cancellables)
        $pressureSelectedInputType
            .sink { [weak self] _ in
                self?.pressureConversionOutput = ""
            }
            .store(in: &cancellables)
    }

    func runLengthConversion(
        inputLengthValue: String? = nil,
        selectionInput: LengthType? = nil,
        selectionOutput: LengthType? = nil
    ) {
        let length = inputLengthValue?.toDouble() ?? inputValue.toDouble()
        let inputType = (selectionInput ?? boundSelectionInput) ?? .metres
        let outputType = (selectionOutput ?? boundSelectionOutput) ?? .feet
        
        let inputLength: Measurement<UnitLength> = .init(value: length, unit: inputType.unitLength)
        
        let calculation = inputLength.converted(to: outputType.unitLength).value
        if (calculation == 0) {
            outputValue = ""
        } else {
            outputValue = calculation.toDecimalString(decimalPlaces: 4)
        }
    }
    
    func convertAirspeed() {
        if airspeedTemperature.isEmpty {
            airspeedTemperatureBottomConfig = .init("Required", state: .warning)
            airspeedTemperatureTextFieldStyle = .init(.warning)
            return
        } else {
            airspeedTemperatureBottomConfig = .init(isVisible: false)
            airspeedTemperatureTextFieldStyle = .init(.default)
        }
        
        let temperature: Measurement<UnitTemperature> = .init(value: airspeedTemperature.toDouble(), unit: airspeedTemperatureType?.unitTemperature ?? .celsius)
                
        switch (airspeedInputSelection) {
        case .mach:
            airspeedOutputValue = calculateTAS(mach: airspeedInputValue, temperature: temperature)
        default:
            airspeedOutputValue = calculateMach(tas: airspeedInputValue, temperature: temperature)
        }
    }
    
    private func calculateTAS(mach: String, temperature: Measurement<UnitTemperature>) -> String {
        let speedOfSound = calculateSpeedOfSound(temperature: temperature)
        let machDouble: Double = Double(mach) ?? 0.0
        let tas: Double = machDouble * speedOfSound
        return "\(tas.toDecimalString(decimalPlaces: 4)) m/s"
    }
    
    private func calculateMach(tas: String, temperature: Measurement<UnitTemperature>) -> String {
        let speedOfSound = calculateSpeedOfSound(temperature: temperature)
        let tasDouble: Double = Double(tas) ?? 0.0
        let mach: Double = tasDouble / speedOfSound
        return "Mach \(mach.toDecimalString(decimalPlaces: 4))"
    }
    
    private func calculateSpeedOfSound(temperature: Measurement<UnitTemperature>) -> Double {
        let outsideTemp = temperature.converted(to: .celsius).value
        let squareRoot = sqrt(outsideTemp + 273.15)
        return 38.967854 * squareRoot
    }
    
    func swapPressureFields() {
        switch pressureSelectedInputType {
        case .inhg:
            pressureSelectedInputType = .mb
        case .mb:
            pressureSelectedInputType = .inhg
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
                kgInputFieldStyle = DefaultTextFieldStyle.caution
                lbsInputString = ""
            } else {
                kgInputFieldStyle = DefaultTextFieldStyle.default
                lbInputFieldStyle = DefaultTextFieldStyle.advisory
            }
        }

        else {
            emptyFields = lbsInputString.isEmpty
            if emptyFields { // if the field is empty, adjust the style of the empty field & reset the converted display
                lbInputFieldStyle = DefaultTextFieldStyle.caution
                kgInputString = ""
            } else {
                lbInputFieldStyle = DefaultTextFieldStyle.default
                kgInputFieldStyle = DefaultTextFieldStyle.advisory
            }
        }
    }

    func convertStaticUnits() {
        checkForEmptyFields()
        if !emptyFields {
            runWeightConversion()
        }
    }

    func runWeightConversion() {
        if weightValuesSwapped {
            let lbsDecimal = toDecimal(string: kgInputString)
            let convertedValue = convertKgsToLbs(kgs: lbsDecimal)
            lbsInputString = toString2DP(value: convertedValue)
        } else {
            let kgDecimal = toDecimal(string: lbsInputString)
            let convertedValue = convertLbsToKg(lbs: kgDecimal)
            kgInputString = toString2DP(value: convertedValue)
        }
    }
    
    func convertPressure() {
        let pressure: Measurement<UnitPressure> = .init(value:
                                                            pressureConversionInput.toDouble(), unit: pressureSelectedInputType.unitPressure)
        
        
        switch pressureSelectedInputType {
        case .inhg:
            pressureConversionOutput = "\(pressure.converted(to: .millibars).value.toDecimalString(decimalPlaces: 2)) mg"
        case .mb:
            pressureConversionOutput = "\(pressure.converted(to: .inchesOfMercury).value.toDecimalString(decimalPlaces: 2)) inHg"
        }
    }
}
