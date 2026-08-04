//
//  DemoStrings.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import Foundation

extension UnitConverter {
    
    // MARK: General
    internal static let screenTitle = "Unit Converter"
    internal static let convertButton = "Convert"
    internal static let required = "Required"
    
    // MARK: Weight
    internal static let weightTitle = "Weight Converter"
    internal static let weightSubTitle = "Example of fixed weight conversion with reversable function"
    internal static let weightKgsLabel = "Kilograms"
    internal static let weightKgsHint = "Enter Kgs"
    internal static let weightLbsLabel = "Pounds"
    internal static let weightLbsHint = "Enter Lbs"
    
    // MARK: Pressure
    internal static let pressureTitle = "Pressure Converter"
    internal static let pressureSubTitle = "Example of pressure conversion between Inches of Mercury and Millibars"
    internal static let pressureInhgHint = "Inches of Mercury"
    internal static let pressureMbHint = "Millibars"
    
    // MARK: Length
    internal static let lengthTitle = "Length Converter"
    internal static let lengthSubTitle = "Example of conversion with Menu Picker"
    internal static let lengthHint = "Enter Length"
    internal static let lengthResultHint = "Calculated Result"
    
    // MARK: Airspeed
    internal static let airspeedTitle = "Airspeed Converter"
    internal static let airspeedSubTitle = "Example of converting between Mach and TAS with required fields"
    internal static let airspeedOatHint = "Outside Air Temperature"
    internal static let airspeedMachHint = "Mach Number"
    internal static let airspeedTasHint = "True Airspeed"
    
}

extension CrossWindCalculator {
    
    // MARK: Titles
    internal static let crosswindTitle = "Crosswind Calculator"
    internal static let crosswindResultsTitle = "Results"
    
    // MARK: Inputs
    internal static let runwayHeadingLabel = "Runway Name"
    internal static let windSpeedLabel = "Wind Speed"
    internal static let windDirectionLabel = "Wind Direction"
    
    internal static let runwayHeadingPlaceholder = "1"
    internal static let windSpeedPlaceholder = "0.0 Kts"
    internal static let windDirectionPlaceholder = "0°"
    internal static let windDirectionError = "Must be between 0° and 360°"
    
    // MARK: Outputs
    internal static let headwindLabel = "Headwind"
    internal static let crosswindLabel = "Crosswind"
    internal static let outputUnit = "Kts"
    
}
