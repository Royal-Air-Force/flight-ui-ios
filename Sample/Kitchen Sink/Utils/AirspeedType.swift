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
}
