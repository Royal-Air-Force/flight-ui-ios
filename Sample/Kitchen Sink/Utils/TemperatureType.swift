//
//  TemperatureType.swift
//  flight-ui-ios
//
//  Created by Appivate 2024
//

import Foundation

enum TemperatureType: String, CaseIterable, CustomStringConvertible {
    case celcius = "°C"
    case kelvin = "K"

    var description: String {
        return rawValue
    }

    var unitTemperature: UnitTemperature {
        switch self {
        case .celcius:
            return UnitTemperature.celsius
        case .kelvin:
            return UnitTemperature.kelvin
        }
    }
}