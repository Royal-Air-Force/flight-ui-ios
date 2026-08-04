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

    private var cancellables = Set<AnyCancellable>()

    init() {
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
        let directionRadians = degreesToRadians(direction)
        let runwayRadians = degreesToRadians(runwayHeadingInDegrees(runway))
        
        let crosswind = abs(speed * sin(directionRadians - runwayRadians))
        let headwind = abs(speed * cos(directionRadians - runwayRadians))
        
        crosswindOutput = formatOutputUnits(crosswind.toDecimalString(decimalPlaces: 2))
        headwindOutput = formatOutputUnits(headwind.toDecimalString(decimalPlaces: 2))
    }
    
    func formatOutputUnits(_ value: String) -> String {
        return "\(value) \(CrossWindCalculator.outputUnit)"
    }
    
    func clearCalculations() {
        crosswindOutput = ""
        headwindOutput = ""
    }

    func runwayHeadingInDegrees(_ runwayNumber: Double) -> Double {
        return runwayNumber * 10.0
    }

    func degreesToRadians(_ degrees: Double) -> Double {
        return degrees * Double.pi / 180
    }
}
