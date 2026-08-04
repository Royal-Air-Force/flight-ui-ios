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
    case inches = "Inches"
    case miles = "Miles"
    
    var description: String {
        return rawValue
    }
    
    var unitLength: UnitLength {
        switch self {
        case .feet:
            return UnitLength.feet
        case .metres:
            return UnitLength.meters
        case .inches:
            return UnitLength.inches
        case .miles:
            return UnitLength.miles
        }
    }
    
    var unitSuffix: String {
        switch self {
        case .feet:
            return "ft"
        case .metres:
            return "m"
        case .inches:
            return "in"
        case .miles:
            return "miles"
        }
    }
}
