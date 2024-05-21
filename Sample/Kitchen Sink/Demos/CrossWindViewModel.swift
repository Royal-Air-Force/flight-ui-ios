//
//  CrossWindViewModel.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import Foundation
import Combine
import FlightUI

class CrosswindCalculatorViewModel: ObservableObject {

    @Published var runwayHeading: Int? = 1
    @Published var windSpeed = ""
    @Published var windDirection = ""
    
    @Published var crosswindOutput = ""
    @Published var headwindOutput = ""
    
    @Published var windDirectionTextFieldStyle: InputFieldStyle = .init(.default)
    @Published var windDirectionBottomConfig: BottomLabelConfig = .init(isVisible: false)

    private var calculator: CalculatorService
    private var cancellables = Set<AnyCancellable>()

    init(calculatorService: CalculatorService) {
        self.calculator = calculatorService
        
        Publishers.CombineLatest3($runwayHeading, $windSpeed, $windDirection)
            .sink { [weak self] runwayHeading, windSpeed, windDirection in

                guard !windSpeed.isEmpty, !windDirection.isEmpty, runwayHeading != nil,
                      let windSpeed = Double(windSpeed),
                      let windDirection = Double(windDirection),
                      let runwayHeading = self?.runwayHeading?.toDouble()
                else {
                    self?.clearCalculations()
                    return
                }
                if self?.validateWindDirection(windDirection) ?? false {
                    self?.calculateWinds(speed: windSpeed, direction: windDirection, runway: runwayHeading)
                } else {
                    self?.clearCalculations()
                }
            }
            .store(in: &cancellables)
    }
    
    func validateWindDirection(_ windDirection: Double) -> Bool {
        let validDirection = 0 <= windDirection && windDirection <= 360
        if validDirection {
            windDirectionTextFieldStyle = .init(.default)
            windDirectionBottomConfig = .init(isVisible: false)
        } else {
            windDirectionTextFieldStyle = .init(.warning)
            windDirectionBottomConfig = .init(CrossWindCalculator.windDirectionError, state: .warning, isVisible: true)
        }

        return validDirection
    }
    
    func calculateWinds(speed: Double, direction: Double, runway: Double) {
        
        crosswindOutput = formatOutputUnits(calculator.calculateCrossWind(speed: speed, direction: direction, runway: runway))
        
        headwindOutput = formatOutputUnits(calculator.calculateHeadWind(speed: speed, direction: direction, runway: runway))
    }
    
    func formatOutputUnits(_ value: String) -> String {
        return "\(value) \(CrossWindCalculator.outputUnit)"
    }
    
    func clearCalculations() {
        crosswindOutput = ""
        headwindOutput = ""
    }
}
