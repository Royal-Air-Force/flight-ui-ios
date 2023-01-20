import XCTest
import SwiftUI

import ViewInspector

@testable import FlightUI

class InputFieldTests: XCTestCase {

    // MARK: - Input Field -

    func test_inputField_givenEmptyBinding_whenInputChanged_thenBindingUpdates() throws {
        // given
        let text = Binding<String>(wrappedValue: "")
        let inputField = InputField("",
                                    text: text,
                                    of: .decimal).environmentObject(Theme())

        // when
        try inputField.inspect().view(InputField.self).zStack().textField(0).setInput("Test Binding")

        // then
        XCTAssertEqual(text.wrappedValue, "Test Binding")
    }

    func test_inputField_noStyling_givenEmptyBinding_whenInputChanged_thenBindingUpdates() throws {
        // given
        let text = Binding<String>(wrappedValue: "")
        let inputField = InputField("",
                                    text: text,
                                    of: .decimal,
                                    useThemeStyling: false).environmentObject(Theme())

        // when
        try inputField.inspect().view(InputField.self).zStack().textField(0).setInput("Test Binding")

        // then
        XCTAssertEqual(text.wrappedValue, "Test Binding")
    }

    func test_inputField_givenFormatter_whenInputEntered_thenFormatsCorrectly() throws {
        // given
        let text = Binding<String>(wrappedValue: "")
        let inputField = InputField("",
                                    text: text,
                                    formatter: .decimal(maximumIntegerDigits: 42, maximumFractionDigits: 1),
                                    of: .decimal).environmentObject(Theme())

        // when
        try inputField.inspect().view(InputField.self).zStack().textField(0).setInput("123.123")

        // then
        XCTAssertEqual(text.wrappedValue, "123.1")
    }

    func test_inputField_givenUnformmatedString_thenShowsFormattedString() throws {
        // given
        let text = Binding<String>(wrappedValue: "543.21")
        let inputField = InputField("",
                                    text: text,
                                    formatter: .decimal(maximumIntegerDigits: 42, maximumFractionDigits: 1),
                                    of: .decimal).environmentObject(Theme())

        // then
        XCTAssertEqual(try inputField.inspect().view(InputField.self).zStack().textField(0).input(), "543.2")
    }
}
