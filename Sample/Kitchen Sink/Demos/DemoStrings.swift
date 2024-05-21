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

extension TODCalculator {
    
    // MARK: Titles
    internal static let todCalculatorTitle = "Top of Descent Calculator"
    internal static let startOfDescentTitle = "Start of Descent"
    internal static let descentDistanceTitle = "Descent Distance"
    internal static let descentRateTitle = "Descent Rate"
    internal static let verticalSpeedTitle = "Vertical Speed"
    internal static let todCalculatorClear = "Clear"
    
    // MARK: Start of Descent
    internal static let initialAltitudeLabel = "Initial Altitude (ft)"
    internal static let initialAltitudePlaceholder = "33000 ft"
    internal static let finalAltitudeLabel = "Final Altitude (ft)"
    internal static let finalAltitudePlaceholder = "10000 ft"
    internal static let descentAngleLabel = "Descent Angle (°)"
    internal static let descentAnglePlaceholder = "3°"
    internal static let descentDistanceLabel = "TOD Position (NM)"
    internal static let descentDistanceUnits = "NM"
    
    internal static let descentAngleError = "Must be between 0° and 360°"
    
    // MARK: Descent Rate
    internal static let descentRateLabel = "Descent Rate (%)"
    internal static let descentRatePlaceholder = "5.2%"
    internal static let groundSpeedLabel = "Ground Speed (kts)"
    internal static let groundSpeedPlaceholder = "110 kts"
    internal static let verticalSpeedLabel = "Vertical Speed (ft/min)"
    internal static let verticalSpeedUnits = "ft/min"
    
    internal static let descentRateError = "Must be between 0% and 100%"
    
}
