//
//  WindCalcTests.swift
//  KitchenSinkUnitTests
//
//  Created by Jake Dove on 18/03/2024.
//

import Foundation

import XCTest
@testable import Kitchen_Sink

class WindCalcTests: XCTestCase {

    var viewModel: CrosswindCalculatorViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CrosswindCalculatorViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testCrosswindCalculation() {
        // Given
        viewModel.windSpeed = "10"
        viewModel.windDirection = "90"
        viewModel.runwayNumber = 180

        // When
        viewModel.calculateWindSpeeds(windspeed: 10, windDirection: Double.pi / 2, runwayHeading: Double.pi)

        // Then
        XCTAssertEqual(viewModel.crosswindString, "10.00")
        XCTAssertEqual(viewModel.headwindString, "0.00")
    }

    func testEmptyInput() {
        // Given
        viewModel.windSpeed = ""
        viewModel.windDirection = ""
        viewModel.runwayNumber = nil

        // When
        viewModel.calculateWindSpeeds(windspeed: 0, windDirection: 0, runwayHeading: 0)

        // Then
        XCTAssertEqual(viewModel.crosswindString, "0.00")
        XCTAssertEqual(viewModel.headwindString, "0.00")
    }

    func testwrongValuesInput() {
        // Given
        viewModel.windSpeed = "abc"
        viewModel.windDirection = "45"
        viewModel.runwayNumber = 180

        // When
        viewModel.calculateWindSpeeds(windspeed: 0, windDirection: 0, runwayHeading: 340)

        // Then
        XCTAssertEqual(viewModel.crosswindString, "0.00")
        XCTAssertEqual(viewModel.headwindString, "0.00")
    }



    func testExtremeWindValues() {
        var runwayheadingRadius = 20 * Double.pi / 180
        var windDirectionRadius = viewModel.degreesToRadians(18.0)

        // When
        viewModel.calculateWindSpeeds(windspeed: 800, windDirection: windDirectionRadius, runwayHeading: runwayheadingRadius)

        // Then
        XCTAssertEqual(viewModel.crosswindString, "27.92")
        XCTAssertEqual(viewModel.headwindString, "799.51")
    }

    func testrunwayHeadingInDegrees() {
        XCTAssertEqual(viewModel.runwayHeadingInDegrees(2), 20.0)
        XCTAssertEqual(viewModel.runwayHeadingInDegrees(8), 80.0)
        XCTAssertEqual(viewModel.runwayHeadingInDegrees(12), 120.0)
        XCTAssertEqual(viewModel.runwayHeadingInDegrees(24), 240.0)
        XCTAssertEqual(viewModel.runwayHeadingInDegrees(36), 360.0)

    }
}

