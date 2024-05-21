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
    
    private var calculatorService: CalculatorService
    private var cancellables = Set<AnyCancellable>()
    
    init(_ calculatorService: CalculatorService) {
        self.calculatorService = calculatorService
        setupWeightConverter()
        setupPressureConverter()
        setupLengthConverter()
        setupAirspeedConverter()
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
        if weightConversionInput.isEmpty {
            setWeightWarningValidation()
        } else {
            clearWeightValidation()
            weightConversionOutput = calculatorService.convertWeight(weight: weightConversionInput,
                                                                     inputUnit: weightSelectedInputType, outputUnit: weightSelectedInputType.inverse)
        }
    }
    
    private func setWeightWarningValidation(message: String = UnitConverter.required) {
        weightInputFieldStyle = .init(.warning)
        weightInputBottomLabel = .init(message, state: .warning)
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
        if pressureConversionInput.isEmpty {
            setPressureWarningValidation()
        } else {
            clearPressureValidation()
            
            pressureConversionOutput = calculatorService.convertPressure(pressure: pressureConversionInput,
                                                                         inputUnit: pressureSelectedInputType,
                                                                         outputUnit: pressureSelectedInputType.inverse)
        }
    }
    
    private func setPressureWarningValidation(message: String = UnitConverter.required) {
        pressureInputFieldStyle = .init(.warning)
        pressureInputBottomLabel = .init(message, state: .warning)
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
        if lengthConversionInput.isEmpty {
            setLengthWarningValidation()
        } else {
            clearLengthValidation()
            
            guard let lengthInputType = lengthSelectedInputType, 
                    let lengthOutputType = lengthSelectedOutputType else { return }
            
            lengthConversionOutput = calculatorService.convertLength(length: lengthConversionInput,
                                                                     inputUnit: lengthInputType,
                                                                     outputUnit: lengthOutputType)
        }
    }
    
    private func setLengthWarningValidation(message: String = UnitConverter.required) {
        lengthInputFieldStyle = .init(.warning)
        lengthInputBottomLabel = .init(message, state: .warning)
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
        if airspeedTemperature.isEmpty {
            setTemperatureWarningValidation()
        }
        if airspeedInputValue.isEmpty {
            setAirspeedWarningValidation()
        }
        if airspeedTemperature.isEmpty || airspeedInputValue.isEmpty {
            return
        }
        
        guard let tempType = airspeedTemperatureType, 
                let airspeedType = airspeedInputSelection else { return }
        
        airspeedOutputValue = calculatorService.convertAirspeed(temperature: airspeedTemperature,
                                                                temperatureUnit: tempType,
                                                                airspeed: airspeedInputValue,
                                                                airspeedUnit: airspeedType)
    }
    
    private func setTemperatureWarningValidation(message: String = UnitConverter.required) {
        airspeedTemperatureTextFieldStyle = .init(.warning)
        airspeedTemperatureBottomConfig = .init(message, state: .warning)
    }
    
    private func setAirspeedWarningValidation(message: String = UnitConverter.required) {
        airspeedInputTextFieldStyle = .init(.warning)
        airspeedInputBottomConfig = .init(message, state: .warning)
    }
    
    private func clearAirspeedValidation() {
        airspeedTemperatureTextFieldStyle = .init(.default)
        airspeedTemperatureBottomConfig = .init(isVisible: false)
        airspeedInputTextFieldStyle = .init(.default)
        airspeedInputBottomConfig = .init(isVisible: false)
    }
}
