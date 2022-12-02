//
//  Button+StylesTests.swift
//  FlightUI
//  
//
//  Created by Alan Gorton on 02/12/2022.
//

import XCTest
import SwiftUI

@testable import FlightUI

class ButtonStyleTests: XCTestCase {
    func test_primaryButton() {
        let button = Button(action: { }) {
            Text("NOPE")
        }
        .buttonStyle(.primary)

        XCTAssertNotNil(button)
    }
}
