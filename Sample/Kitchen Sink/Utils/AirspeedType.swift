//
//  AirspeedType.swift
//  Kitchen Sink
//
//  Created by David Jones on 26/03/2024.
//

import Foundation

enum AirspeedType: String, CaseIterable, CustomStringConvertible {
    case mach = "Mach (#)"
    case tas = "TAS (m/s)"
    
    var description: String {
        return rawValue
    }
}
