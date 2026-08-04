//
//  WeightType.swift
//  flight-ui-ios
//
//  Created by Appivate 2024
//

import Foundation

enum WeightType: String, CaseIterable, CustomStringConvertible {
    case kilograms = "kg"
    case pounds = "lbs"
    
    var description: String {
        return rawValue
    }
    
    var unitName: String {
        switch self {
        case .kilograms:
            return UnitConverter.weightKgsLabel
        case .pounds:
            return UnitConverter.weightLbsLabel
        }
    }
    
    var unitMass: UnitMass {
        switch self {
        case .kilograms:
            return UnitMass.kilograms
        case .pounds:
            return UnitMass.pounds
        }
    }
    
    var inverse: WeightType {
        switch self {
        case .kilograms:
            return .pounds
        case .pounds:
            return .kilograms
        }
    }
}
