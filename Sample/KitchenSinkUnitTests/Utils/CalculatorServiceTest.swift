//
//  CalculatorServiceTest.swift
//  KitchenSinkUnitTests
//
//  Created by David Jones on 08/04/2024.
//

import XCTest
@testable import Kitchen_Sink

class CalculatorServiceTest : XCTestCase {
    
    private let service = CalculatorService()
    
    func test_givenConvertWeight_whenInputIsKg_andOutputIsLbs_thenCorrectCalculation() {
        
        let data = [("1", "2.20 lbs"), ("10", "22.05 lbs"),
        ("74", "163.14 lbs"), ("999", "2202.42 lbs"), ("7842", "17288.65 lbs"),
        ("12.3", "27.12 lbs"), ("715.9", "1578.29 lbs"), ("0.05", "0.11 lbs")]
        
        data.forEach { item in
            let converted = service.convertWeight(weight: item.0, inputUnit: .kilograms, outputUnit: .pounds)
            XCTAssertEqual(converted, item.1)
        }
    }
    
    func test_givenConvertWeight_whenInputIsLbs_andOutputIsLbs_thenCorrectCalculation() {
        
        let data = [("1", "0.45 kg"), ("10", "4.54 kg"),
        ("65", "29.48 kg"), ("999", "453.14 kg"), ("9314", "4224.76 kg"),
        ("17.4", "7.89 kg"), ("481.4", "218.36 kg"), ("0.03", "0.01 kg")]
        
        data.forEach {
            let converted = service.convertWeight(weight: $0, inputUnit: .pounds, outputUnit: .kilograms)
            XCTAssertEqual(converted, $1)
        }
    }
    
}
