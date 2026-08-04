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

    // MARK: Weight
    @Published var weightConversionInput: String = ""
    @Published var weightConversionOutput: String = ""
    @Published var weightSelectedInputType: WeightType = .pounds
    @Published var weightInputFieldStyle: InputFieldStyle = .init(.default)
    @Published var weightInputBottomLabel: BottomLabelConfig = .init(WeightType.pounds.unitName)
    var weightConversionInputPlaceholder: String {
        "0.0 \(weightSelectedInputType)"
    }
    var weightConversionOutputPlaceholder: String {
        "0.0 \(weightSelectedInputType.inverse)"
    }
    var weightOutputBottomLabel: String {
        weightSelectedInputType.inverse.unitName
    }
    
    // MARK: Pressure
    @Published var pressureConversionInput: String = ""
    @Published var pressureConversionOutput: String = ""
    @Published var pressureSelectedInputType: PressureType = .inhg
    @Published var pressureInputFieldStyle: InputFieldStyle = .init(.default)
    @Published var pressureInputBottomLabel: BottomLabelConfig = .init(PressureType.inhg.unitName)
    var pressureConversionInputPlaceholder: String {
        "0.0 \(pressureSelectedInputType)"
    }
    var pressureConversionOutputPlaceholder: String {
        "0.0 \(pressureSelectedInputType.inverse)"
    }
    var pressureOutputBottomLabel: String {
        pressureSelectedInputType.inverse.unitName
    }
    
    // MARK: Length
    @Published var lengthConversionInput: String = ""
    @Published var lengthConversionOutput: String = ""
    @Published var lengthSelectedInputType: LengthType? = .feet
    @Published var lengthSelectedOutputType: LengthType? = .metres
    @Published var lengthInputFieldStyle: InputFieldStyle = .init(.default)
    @Published var lengthInputBottomLabel: BottomLabelConfig = .init(isVisible: false)
    
    // MARK: Airspeed
    @Published var airspeedTemperature: String = ""
    @Published var airspeedTemperatureType: TemperatureType? = .celcius
    @Published var airspeedTemperatureBottomConfig: BottomLabelConfig = .init(isVisible: false)
    @Published var airspeedTemperatureTextFieldStyle: InputFieldStyle = .init(.default)
    
    @Published var airspeedInputValue: String = ""
    @Published var airspeedInputPlaceholder: String = ""
    @Published var airspeedInputSelection: AirspeedType? = .tas
    @Published var airspeedInputBottomConfig: BottomLabelConfig = .init(isVisible: false)
    @Published var airspeedInputTextFieldStyle: InputFieldStyle = .init(.default)
    @Published var airspeedOutputPlaceholder: String = ""
    @Published var airspeedOutputValue: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupWeightConverter()
        setupPressureConverter()
        setupLengthConverter()
        setupAirspeedConverter()
    }
    
    func formatInputValue(value: String) -> String {
        guard let decimalValue = Decimal(string: value) else { return value }
        return decimalValue.toDecimalString()
    }
}

// MARK: Weight
extension UnitConverterViewModel {
    
    private func setupWeightConverter() {
        $weightSelectedInputType
            .sink { [weak self] _ in
                self?.weightConversionOutput = ""
            }
            .store(in: &cancellables)
        $weightConversionInput
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.clearWeightValidation()
            }
            .store(in: &cancellables)
    }
    
    func swapWeightFields() {
        weightSelectedInputType = weightSelectedInputType.inverse
        clearWeightValidation()
    }
    
    func convertWeight() {
        if isWeightInputValid() {
            let weight: Measurement<UnitMass> = .init(
                value: weightConversionInput.toDouble(),
                unit: weightSelectedInputType.unitMass)
            
            switch weightSelectedInputType {
            case .kilograms:
                weightConversionOutput = "\(weight.converted(to: .pounds).value.toDecimalString(decimalPlaces: 2)) lbs"
            case .pounds:
                weightConversionOutput = "\(weight.converted(to: .kilograms).value.toDecimalString(decimalPlaces: 2)) kgs"
            }
        }
    }
    
    private func isWeightInputValid() -> Bool {
        if weightConversionInput.isEmpty {
            weightInputFieldStyle = .init(.warning)
            weightInputBottomLabel = .init(UnitConverter.required, state: .warning)
            return false
        } else {
            clearWeightValidation()
            return true
        }
    }
    
    private func clearWeightValidation() {
        weightInputFieldStyle = .init(.default)
        weightInputBottomLabel = .init(weightSelectedInputType.unitName, state: .default)
    }
    
}

// MARK: Pressure
extension UnitConverterViewModel {
    
    private func setupPressureConverter() {
        $pressureSelectedInputType
            .sink { [weak self] _ in
                self?.pressureConversionOutput = ""
            }
            .store(in: &cancellables)
        $pressureConversionInput
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.clearPressureValidation()
            }
            .store(in: &cancellables)
    }
    
    func swapPressureFields() {
        pressureSelectedInputType = pressureSelectedInputType.inverse
        clearPressureValidation()
    }
    
    func convertPressure() {
        if isPressureInputValid() {
            let pressure: Measurement<UnitPressure> =
                .init(value: pressureConversionInput.toDouble(),
                      unit: pressureSelectedInputType.unitPressure)

            switch pressureSelectedInputType {
            case .inhg:
                pressureConversionOutput = "\(pressure.converted(to: .millibars).value.toDecimalString(decimalPlaces: 2)) mb"
            case .mb:
                pressureConversionOutput = "\(pressure.converted(to: .inchesOfMercury).value.toDecimalString(decimalPlaces: 2)) inHg"
            }
        }
    }
    
    private func isPressureInputValid() -> Bool {
        if pressureConversionInput.isEmpty {
            pressureInputFieldStyle = .init(.warning)
            pressureInputBottomLabel = .init(UnitConverter.required, state: .warning)
            return false
        } else {
            clearPressureValidation()
            return true
        }
    }
    
    private func clearPressureValidation() {
        pressureInputFieldStyle = .init(.default)
        pressureInputBottomLabel = .init(pressureSelectedInputType.unitName, state: .default)
    }
}

// MARK: Length
extension UnitConverterViewModel {
    
    private func setupLengthConverter() {
        $lengthSelectedInputType
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.lengthConversionOutput = ""
                self?.clearLengthValidation()
            }
            .store(in: &cancellables)
        $lengthSelectedOutputType
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.lengthConversionOutput = ""
                self?.clearLengthValidation()
            }
            .store(in: &cancellables)
        $lengthConversionInput
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.clearLengthValidation()
            }
            .store(in: &cancellables)
    }
    
    func runLengthConversion() {
        if isLengthInputValid() {
            let length: Measurement<UnitLength> =
                .init(value: lengthConversionInput.toDouble(),
                      unit: lengthSelectedInputType?.unitLength ?? .meters)

            switch lengthSelectedOutputType {
            case .metres:
                lengthConversionOutput = "\(length.converted(to: .meters).value.toDecimalString(decimalPlaces: 2)) m"
            case .feet:
                lengthConversionOutput = "\(length.converted(to: .feet).value.toDecimalString(decimalPlaces: 2)) ft"
            default:
                lengthConversionOutput = ""
            }
        }
    }
    
    private func isLengthInputValid() -> Bool {
        if lengthConversionInput.isEmpty {
            lengthInputFieldStyle = .init(.warning)
            lengthInputBottomLabel = .init(UnitConverter.required, state: .warning)
            return false
        } else {
            clearLengthValidation()
            return true
        }
    }
    
    private func clearLengthValidation() {
        lengthInputFieldStyle = .init(.default)
        lengthInputBottomLabel = .init(isVisible: false)
    }
}

// MARK: Airspeed
extension UnitConverterViewModel {
    
    private func setupAirspeedConverter() {
        $airspeedTemperature
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.clearAirspeedValidation()
            }
            .store(in: &cancellables)
        
        $airspeedInputValue
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.clearAirspeedValidation()
            }
            .store(in: &cancellables)
        
        $airspeedInputSelection
            .sink { [weak self] airspeedSelection in
                self?.airspeedOutputValue = ""
                self?.airspeedInputPlaceholder = airspeedSelection?.unitName ?? ""
                self?.airspeedOutputPlaceholder = airspeedSelection?.inverse.unitName ?? ""
                self?.clearAirspeedValidation()
            }
            .store(in: &cancellables)
        $airspeedTemperatureType
            .sink { [weak self] _ in
                self?.airspeedOutputValue = ""
                self?.clearAirspeedValidation()
            }
            .store(in: &cancellables)
    }
    
    func convertAirspeed() {
        if isAirspeedInputValid() {
            let temperature: Measurement<UnitTemperature> = .init(value: airspeedTemperature.toDouble(), unit: airspeedTemperatureType?.unitTemperature ?? .celsius)

            switch (airspeedInputSelection) {
            case .mach:
                airspeedOutputValue = calculateTAS(mach: airspeedInputValue, temperature: temperature)
            default:
                airspeedOutputValue = calculateMach(tas: airspeedInputValue, temperature: temperature)
            }
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
    
    private func isAirspeedInputValid() -> Bool {
        var isValid = true
        
        if airspeedTemperature.isEmpty {
            airspeedTemperatureTextFieldStyle = .init(.warning)
            airspeedTemperatureBottomConfig = .init(UnitConverter.required, state: .warning)
            isValid = false
        }
        if airspeedInputValue.isEmpty {
            airspeedInputTextFieldStyle = .init(.warning)
            airspeedInputBottomConfig = .init(UnitConverter.required, state: .warning)
            isValid = false
        }
        
        if isValid {
            clearLengthValidation()
            return true
        } else {
            return false
        }
    }
    
    private func clearAirspeedValidation() {
        airspeedTemperatureTextFieldStyle = .init(.default)
        airspeedTemperatureBottomConfig = .init(isVisible: false)
        airspeedInputTextFieldStyle = .init(.default)
        airspeedInputBottomConfig = .init(isVisible: false)
    }
}
