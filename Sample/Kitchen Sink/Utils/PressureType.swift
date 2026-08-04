//
//  PressureType.swift
//  flight-ui-ios
//
//  Created by Appivate 2024
//

import Foundation

enum PressureType: String, CaseIterable, CustomStringConvertible {
    case inhg = "inHg"
    case mb = "mb"

    var description: String {
        return rawValue
    }

    var unitPressure: UnitPressure {
        switch self {
        case .inhg:
            return UnitPressure.inchesOfMercury
        case .mb:
            return UnitPressure.millibars
        }
    }

    var inverse: PressureType {
        switch self {
        case .inhg:
            return .mb
        case .mb:
            return .inhg
        }
    }
}
