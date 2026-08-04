//
//  CalculatorService.swift
//  Kitchen Sink
//
//  Created by Appivate 2024
//

import Foundation

class CalculatorService {
    
    func convertWeight(weight: String,
                       inputUnit: WeightType,
                       outputUnit: WeightType) -> String {
        let weightMeasurement: Measurement<UnitMass> = .init(value: weight.toDouble(),
                                                             unit: inputUnit.unitMass)
        let convertedValue = weightMeasurement.converted(to: outputUnit.unitMass).value
        return "\(convertedValue.toDecimalString(decimalPlaces: 2)) \(outputUnit.description)"
    }
    
    func convertLength(length: String,
                       inputUnit: LengthType,
                       outputUnit: LengthType) -> String {
        let lengthMeasurement: Measurement<UnitLength> = .init(value: length.toDouble(),
                                                               unit: inputUnit.unitLength)
        let convertedValue = lengthMeasurement.converted(to: outputUnit.unitLength).value
        return "\(convertedValue.toDecimalString(decimalPlaces: 2)) \(outputUnit.unitSuffix)"
    }
    
    func convertPressure(pressure: String,
                         inputUnit: PressureType,
                         outputUnit: PressureType) -> String {
        let pressureMeasurement: Measurement<UnitPressure> = .init(value: pressure.toDouble(),
                                                                   unit: inputUnit.unitPressure)
        let convertedValue = pressureMeasurement.converted(to: outputUnit.unitPressure).value
        return "\(convertedValue.toDecimalString(decimalPlaces: 2)) \(outputUnit.description)"
    }
    
    func convertAirspeed(temperature: String,
                         temperatureUnit: TemperatureType,
                         airspeed: String,
                         airspeedUnit: AirspeedType) -> String {
        let temperatureMeasurement: Measurement<UnitTemperature> = .init(value: temperature.toDouble(), unit: temperatureUnit.unitTemperature)
        
        let speedOfSound = calculateSpeedOfSound(temperature: temperatureMeasurement)
        
        switch airspeedUnit {
        case .mach:
            return calculateTAS(mach: airspeed.toDouble(), speedOfSound: speedOfSound)
        case .tas:
            return calculateMach(tas: airspeed.toDouble(), speedOfSound: speedOfSound)
        }
    }
    
    private func calculateTAS(mach: Double, speedOfSound: Double) -> String {
        let tas = mach * speedOfSound
        return "\(tas.toDecimalString(decimalPlaces: 4)) m/s"
    }
    
    private func calculateMach(tas: Double, speedOfSound: Double) -> String {
        let mach = tas / speedOfSound
        return "Mach \(mach.toDecimalString(decimalPlaces: 4))"
    }
    
    private func calculateSpeedOfSound(temperature: Measurement<UnitTemperature>) -> Double {
        let outsideTemp = temperature.converted(to: .celsius).value
        let squareRoot = sqrt(outsideTemp + 273.15)
        return 38.967854 * squareRoot
    }
    
}
