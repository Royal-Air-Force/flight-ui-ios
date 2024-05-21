//
//  TODCalculatorViewModel.swift
//  flight-ui-ios
//
//  Created by Appivate 2024
//

import Foundation
import Combine
import FlightUI

class TODCalculatorViewModel: ObservableObject {
    
    @Published var initialAltitudeInput = ""
    @Published var finalAltitudeInput = ""
    @Published var descentAngleInput = ""
    
    @Published var descentAngleTextFieldStyle: InputFieldStyle = .init(.default)
    @Published var descentAngleBottomConfig: BottomLabelConfig = .init(isVisible: false)
    
    @Published var descentRateInput = ""
    @Published var groundSpeedInput = ""
    
    @Published var descentRateTextFieldStyle: InputFieldStyle = .init(.default)
    @Published var descentRateBottomConfig: BottomLabelConfig = .init(isVisible: false)
    
    @Published var descentDistanceOutput = ""
    @Published var verticalSpeedOutput = ""
    
    private var calculator: CalculatorService
    private var cancellables = Set<AnyCancellable>()
    
    init(calculatorService: CalculatorService) {
        self.calculator = calculatorService
        
        $descentAngleInput
            .sink { [weak self] descentAngle in
                guard !descentAngle.isEmpty, let descentAngle = Double(descentAngle) else { return }
                
                _ = self?.validateDescentAngle(descentAngle)
            }
            .store(in: &cancellables)
        
        $descentRateInput
            .sink { [weak self] descentRate in
                guard !descentRate.isEmpty, let descentRate = Double(descentRate) else { return }
                
                _ = self?.validateDescentRate(descentRate)
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest3($initialAltitudeInput, $finalAltitudeInput, $descentAngleInput)
            .sink { [weak self] initialAltitude, finalAltitude, descentAngle in
                
                guard !initialAltitude.isEmpty, !finalAltitude.isEmpty, !descentAngle.isEmpty,
                    let initialAltitude = Double(initialAltitude),
                      let finalAltitude = Double(finalAltitude),
                      let descentAngle = Double(descentAngle)
                else {
                    self?.clearDescentDistance()
                    return
                }
                
                if self?.validateDescentAngle(descentAngle) ?? false {
                    self?.descentDistanceOutput = self?.formatDescentDistance(self?.calculator.calculateDecentDistance(initialAltitude: initialAltitude, finalAltitude: finalAltitude, descentAngle: descentAngle) ?? "") ?? ""
                } else {
                    self?.clearDescentDistance()
                }
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest($descentRateInput, $groundSpeedInput)
            .sink { [weak self] descentRate, groundSpeed in
                
                guard !descentRate.isEmpty, !groundSpeed.isEmpty,
                      let descentRate = Double(descentRate),
                      let groundSpeed = Double(groundSpeed)
                else {
                    self?.clearVerticalSpeed()
                    return
                }
                
                if self?.validateDescentRate(descentRate) ?? false {
                    let verticalSpeed = self?.calculator.calculateVerticalSpeed(descentRate: descentRate, groundSpeed: groundSpeed) ?? ""
                    self?.verticalSpeedOutput = self?.formatVerticalSpeed(verticalSpeed) ?? ""
                    
//                    self?.verticalSpeedOutput =
//                    self?.formatVerticalSpeed(self?.calculator.calculateVerticalSpeed(descentRate: descentRate, groundSpeed: groundSpeed)) ?? ""
                } else {
                    self?.clearVerticalSpeed()
                }
            }
            .store(in: &cancellables)
    }
    
    func validateDescentAngle(_ descentAngle: Double) -> Bool {
        let validAngle = 0 <= descentAngle && descentAngle <= 360
        if validAngle {
            descentAngleTextFieldStyle = .init(.default)
            descentAngleBottomConfig = .init(isVisible: false)
        } else {
            descentAngleTextFieldStyle = .init(.warning)
            descentAngleBottomConfig = .init(TODCalculator.descentAngleError, state: .warning, isVisible: true)
        }
        return validAngle
    }
    
    func validateDescentRate(_ descentRate: Double) -> Bool {
        let validRate = 0 <= descentRate && descentRate <= 100
        if validRate {
            descentRateTextFieldStyle = .init(.default)
            descentRateBottomConfig = .init(isVisible: false)
        } else {
            descentRateTextFieldStyle = .init(.warning)
            descentRateBottomConfig = .init(TODCalculator.descentRateError, state: .warning, isVisible: true)
        }
        return validRate
    }
    
    func formatDescentDistance(_ descentDistance: String) -> String {
        return "\(descentDistance) \(TODCalculator.descentDistanceUnits)"
    }
    
    func formatVerticalSpeed(_ verticalSpeed: String) -> String {
        return "\(verticalSpeed) \(TODCalculator.verticalSpeedUnits)"
    }
    
    func clearDescentDistance() {
        descentDistanceOutput = ""
    }
    
    func clearVerticalSpeed() {
        verticalSpeedOutput = ""
    }
    
    func clearInputs() {
        initialAltitudeInput = ""
        finalAltitudeInput = ""
        descentAngleInput = ""
        descentRateInput = ""
        groundSpeedInput = ""
    }
    
}
