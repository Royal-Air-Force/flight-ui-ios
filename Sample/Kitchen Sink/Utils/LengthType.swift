//
//  LengthType.swift
//  Kitchen Sink
//
//  Created by David Jones on 26/03/2024.
//

import Foundation

enum LengthType: String, CaseIterable, CustomStringConvertible {
    case feet = "Feet"
    case metres = "Metres"
    case yards = "Yards"
    case inches = "Inches"
    
    var description: String {
        return rawValue
    }
    
    var unitLength: UnitLength {
        switch self {
        case .feet:
            return UnitLength.feet
        case .metres:
            return UnitLength.meters
        case .yards:
            return UnitLength.yards
        case .inches:
            return UnitLength.inches
        }
    }
}
