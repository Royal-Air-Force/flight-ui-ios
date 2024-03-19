//
//  Shape+Extensions.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import Foundation
import Combine


class CrosswindCalculatorViewModel: ObservableObject {

    @Published var windSpeedPlaceholder = "0.0 Kts"
    @Published var windDirectionPlaceholder = "0°"

    @Published var windSpeed = ""
    @Published var windDirection = ""
    @Published var crosswindString = ""
    @Published var headwindString = ""
    @Published var runwayNumber: Int?

    let windSpeedLabel = "Wind speed"
    let runwayNumberLabel = "Runway number"
    let windDirectionLabel = "Wind Direction"
    let headwindLabel = "Headwind"
    let crosswindLabel = "Crosswind"

    @Published private var crosswind: Double = 0
    @Published private var headwind: Double = 0
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Combine publishers to observe changes to input values and update crosswind and headwind
        Publishers.CombineLatest3($windSpeed, $windDirection, $runwayNumber)
            .sink { [weak self] windSpeed, windDirection, runwayHeading in

                guard !windSpeed.isEmpty, !windDirection.isEmpty, runwayHeading != nil,
                      let windSpeedValue = Double(windSpeed),
                      let windDirectionValue = Double(windDirection),
                      let runwayNumberDouble = self?.runwayNumber?.toDouble()
                else {
                    return
                }
                //if the 3 required fields are not null:
                self!.convertValuesToRadians(runwayNumberDouble, windDirectionValue, windSpeedValue)
            }
            .store(in: &cancellables)
    }

    func convertValuesToRadians(_ runwayNumber: Double, _ windDirection: Double, _ windSpeed: Double) {
        let windDirectionRadians = degreesToRadians(windDirection)
        let airplaneHeadingRadians = degreesToRadians(runwayHeadingInDegrees(runwayNumber))
        calculateWindSpeeds(windspeed: windSpeed, windDirection: windDirectionRadians, runwayHeading: airplaneHeadingRadians)
    }

    func calculateWindSpeeds(windspeed: Double, windDirection: Double, runwayHeading: Double) {
        let crosswind = windspeed * sin(windDirection - runwayHeading)
        let headwind = windspeed * cos(windDirection - runwayHeading)
        let absoluteCrosswindComponent = abs(crosswind)
        let absoluteHeadwindComponent = abs(headwind)
        crosswindString = toString2DP(value: absoluteCrosswindComponent)
        headwindString = toString2DP(value: absoluteHeadwindComponent)
    }

    func runwayHeadingInDegrees(_ runwayNumber: Double) -> Double {
        return runwayNumber * 10.0
    }

    func toString2DP(value: Double) -> String {
        return String(format: "%.2f", value)
    }

    func degreesToRadians(_ degrees: Double) -> Double {
        return degrees * Double.pi / 180
    }
}

extension Int {
    func toDouble() -> Double {
        return Double(self)
    }

}

