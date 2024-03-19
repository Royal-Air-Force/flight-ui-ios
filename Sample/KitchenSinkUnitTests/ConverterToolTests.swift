//
//  Shape+Extensions.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import XCTest
import SwiftUI
@testable import Kitchen_Sink


final class ConverterToolTest: XCTestCase {

    var viewModel: UnitConverterViewModel!

    override func setUpWithError() throws {
        viewModel = UnitConverterViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testLengthConversion() {
        viewModel.inputValue = "10"
        viewModel.boundSelectionInput = .feet
        viewModel.boundSelectionOutput = .metres
        viewModel.runLengthConversion()
        XCTAssertEqual(viewModel.outputValue, "3.05") // 10 feet should be approximately 3.05 meters
    }

    func testKgToLbsConversion() {
        viewModel.kgInputString = "10"
        viewModel.runWeightConversion(kgToLbConversion: true)
        XCTAssertEqual(viewModel.lbsInputString, "22.05") // 10 kilograms should be approximately 22.05 pounds
    }

    func testLbsToKgConversion() {
        viewModel.lbsInputString = "22.05"
        viewModel.runWeightConversion(kgToLbConversion: false)
        XCTAssertEqual(viewModel.kgInputString, "10.00") // 22.05 pounds should be approximately 10 kilograms
    }

    func testFieldsAreEmpty() {
        XCTAssertTrue(viewModel.fieldsAreEmpty()) // Initially, both input fields should be empty
        viewModel.kgInputString = "10"
        XCTAssertFalse(viewModel.fieldsAreEmpty()) // After setting kgInputString, the fields should not be empty
    }

    func testToDecimal() {
        XCTAssertEqual(viewModel.toDecimal(string: "10"), 10.0) // Valid string should convert to double
        XCTAssertEqual(viewModel.toDecimal(string: "3.25"), 3.25) // Valid string should convert to double
        XCTAssertEqual(viewModel.toDecimal(string: ""), 0.0) // Empty string should convert to 0.0
        XCTAssertEqual(viewModel.toDecimal(string: "abc"), 0.0) // Invalid string should convert to 0.0
    }

    func testToString2DP() {
        XCTAssertEqual(viewModel.toString2DP(value: 10.12345), "10.12") // Double value should be formatted to 2 decimal places
        XCTAssertEqual(viewModel.toString2DP(value: 10.00), "10.00") // Integer value should be formatted with 2 decimal places
    }

    func testConvertToMeters() {
        XCTAssertEqual(viewModel.convertToMeters(value: 10, from: .feet), 3.047999902464003072, accuracy: 0.001) // 10 feet should be approximately 3.048 meters
        XCTAssertEqual(viewModel.convertToMeters(value: 10, from: .metres), 10) // Value in meters should remain the same
    }

    func testConvertFromMeters() {
        XCTAssertEqual(viewModel.convertFromMeters(value: 10, from: .metres), 10) // Value in meters should remain the same
        XCTAssertEqual(viewModel.convertFromMeters(value: 10, from: .feet), 32.80839895013123072, accuracy: 0.001) // 10 meters should be approximately 32.8084 feet
    }

    func testConvertKgsToLbs() {
        XCTAssertEqual(viewModel.convertKgsToLbs(kgs: 10), 22.04622620000000512, accuracy: 0.001) // 10 kilograms should be approximately 22.05 pounds
    }

    func testConvertLbsToKg() {
        XCTAssertEqual(viewModel.convertLbsToKg(lbs: 22.05), 10.00171176688734208, accuracy: 0.001) // 22.05 pounds should be approximately 10 kilograms
    }
}
