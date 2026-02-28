import XCTest

@testable import FlightUI

final class FilterTests: XCTestCase {

    func test_integerOnly_regex() {
        XCTAssertEqual(RegexFilter.integerOnly.regex, "[^0-9]")
    }

    func test_doubleOnly_regex() {
        XCTAssertEqual(RegexFilter.doubleOnly.regex, "[^0-9.]")
    }

    func test_letterOnly_regex() {
        XCTAssertEqual(RegexFilter.letterOnly.regex, "[^A-Z^a-z]")
    }

    func test_noDigits_regex() {
        XCTAssertEqual(RegexFilter.noDigits.regex, "[0-9]")
    }

    func test_custom_returnsProvidedRegex() {
        XCTAssertEqual(RegexFilter.custom("[^A-F0-9]").regex, "[^A-F0-9]")
    }
}
