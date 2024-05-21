//
//  CrossWindViewModel.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import Foundation
import Combine


class CrosswindCalculatorViewModel: ObservableObject {

    @Published var windSpeedPlaceholder = "0.0 Kts"
    @Published var windDirectionPlaceholder = "0°"

    @Published var runwayHeading: Int? = 1
    @Published var windSpeed = ""
    @Published var windDirection = ""
    
    @Published var crosswindOutput = ""
    @Published var headwindOutput = ""

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
                self?.calculateWinds(speed: windSpeed, direction: windDirection, runway: runwayHeading)
            }
            .store(in: &cancellables)
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
