//
//  LengthType.swift
//  flight-ui-ios
//
//  Created by Appivate 2024
//

import Foundation

enum LengthType: String, CaseIterable, CustomStringConvertible {
    case feet = "Feet"
    case metres = "Metres"
    
    var description: String {
        return rawValue
    }
    
    var unitLength: UnitLength {
        switch self {
        case .feet:
            return UnitLength.feet
        case .metres:
            return UnitLength.meters
        }
    }
}
