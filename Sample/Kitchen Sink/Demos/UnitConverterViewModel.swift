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
    
    // MARK: Airspeed
    @Published var airspeedTemperature: String = ""
    @Published var airspeedTemperatureType: TemperatureType? = .celcius
    @Published var airspeedTemperatureBottomConfig: BottomLabelConfig = .init(isVisible: false)
    @Published var airspeedTemperatureTextFieldStyle: InputFieldStyle = .init(.default)
    
    @Published var airspeedInputValue: String = ""
    @Published var airspeedInputPlaceholder: String = ""
    @Published var airspeedInputSelection: AirspeedType? = .tas
    @Published var airspeedOutputPlaceholder: String = ""
    @Published var airspeedOutputValue: String = ""
    
    // MARK: Pressure
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
        return pressureSelectedInputType.unitName
    }
    var pressureOutputBottomLabel: String {
        return pressureSelectedInputType.inverse.unitName
    }
    
    private let feetToMetresConversionRate: Decimal = 3.28084
    private let metresToFeetConversionRate: Decimal = 0.3048006096
    private let kgToLbConversionRate: Decimal = 2.20462262
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $airspeedInputSelection
            .sink { [weak self] airspeedSelection in
                self?.airspeedOutputValue = ""
                self?.airspeedInputPlaceholder = airspeedSelection?.unitName ?? ""
                self?.airspeedOutputPlaceholder = airspeedSelection?.inverse.unitName ?? ""
            }
            .store(in: &cancellables)
        $airspeedTemperatureType
            .sink { [weak self] _ in
                self?.airspeedOutputValue = ""
            }
            .store(in: &cancellables)
        
        $pressureSelectedInputType
            .sink { [weak self] _ in
                self?.pressureConversionOutput = ""
            }
            .store(in: &cancellables)
    }

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

    func swapWeightFields() {
        weightValuesSwapped.toggle()
        convertStaticUnits()
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
        if emptyFields {
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

    enum LengthType: String, CaseIterable, CustomStringConvertible {
        case feet = "Feet"
        case metres = "Metres"
        var description: String {
            return rawValue
        }
    }
    
    
    // MARK: Airspeed Functions
    func convertAirspeed() {
        if airspeedTemperature.isEmpty {
            airspeedTemperatureBottomConfig = .init(UnitConverter.required, state: .warning)
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
    
    // MARK: Pressure Functions
    func swapPressureFields() {
        switch pressureSelectedInputType {
        case .inhg:
            pressureSelectedInputType = .mb
        case .mb:
            pressureSelectedInputType = .inhg
        }
    }
    
    func convertPressure() {
        let pressure: Measurement<UnitPressure> = .init(value:
                                                    pressureConversionInput.toDouble(),
                                                        unit: pressureSelectedInputType.unitPressure)

        switch pressureSelectedInputType {
        case .inhg:
            pressureConversionOutput = "\(pressure.converted(to: .millibars).value.toDecimalString(decimalPlaces: 2)) mb"
        case .mb:
            pressureConversionOutput = "\(pressure.converted(to: .inchesOfMercury).value.toDecimalString(decimalPlaces: 2)) inHg"
        }
    }
}
