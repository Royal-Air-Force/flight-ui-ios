//
//  AirspeedType.swift
//  flight-ui-ios
//
//  Created by Appivate 2024
//

import Foundation

enum AirspeedType: String, CaseIterable, CustomStringConvertible {
    case mach = "Mach (#)"
    case tas = "TAS (m/s)"

    var description: String {
        return rawValue
    }
    
    var inverse: AirspeedType {
        switch self {
        case .mach:
            return .tas
        case .tas:
            return .mach
        }
    }
    
    var unitName: String {
        switch self {
        case .mach:
            return UnitConverter.airspeedMachHint
        case .tas:
            return UnitConverter.airspeedTasHint
        }
    }
}
