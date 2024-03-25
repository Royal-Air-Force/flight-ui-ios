import XCTest
import SwiftUI

import ViewInspector

@testable import FlightUI

class InputFieldTests: XCTestCase {

    // MARK: - Input Field -

    func test_inputField_givenEmptyBinding_whenInputChanged_thenBindingUpdates() throws {
        // given
        let text = Binding<String>(wrappedValue: "")
        let inputField = InputField(text: text).environmentObject(Theme())

        // when
        try inputField.inspect().view(InputField.self).vStack().textField(1).setInput("Test Binding")

        // then
        XCTAssertEqual(text.wrappedValue, "Test Binding")
    }

    func test_inputField_noStyling_givenEmptyBinding_whenInputChanged_thenBindingUpdates() throws {
        // given
        let text = Binding<String>(wrappedValue: "")
        let inputField = InputField(text: text).environmentObject(Theme())

        // when
        try inputField.inspect().view(InputField.self).vStack().textField(1).setInput("Test Binding")

        // then
        XCTAssertEqual(text.wrappedValue, "Test Binding")
    }
}
