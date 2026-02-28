import XCTest

@testable import FlightUI

final class NumberFormattingTests: XCTestCase {

    // MARK: - decimal(maxInteger:fractionDigits:)

    func test_decimal_truncatesAndPadsFractionDigits() {
        let style = NumberFormatting.decimal(maxInteger: 5, fractionDigits: 2)
        XCTAssertEqual(3.14159.formatted(style), "3.14")
        XCTAssertEqual(1.0.formatted(style), "1.00")
    }

    func test_decimal_alwaysShowsDecimalSeparator() {
        let style = NumberFormatting.decimal(maxInteger: 5, fractionDigits: 0)
        XCTAssertTrue(0.0.formatted(style).contains("."))
    }

    // MARK: - decimal(maxInteger:minFraction:maxFraction:)

    func test_decimal_flexible_respectsFractionBounds() {
        let style = NumberFormatting.decimal(maxInteger: 5, minFraction: 2, maxFraction: 4)
        XCTAssertEqual(1.0.formatted(style), "1.00")   // pads to min
        XCTAssertEqual(1.5.formatted(style), "1.50")   // no trailing zeros beyond min
    }

    // MARK: - integer(minDigits:maxDigits:)

    func test_integer_padsWithLeadingZeros() {
        let style = NumberFormatting.integer(minDigits: 3, maxDigits: 3)
        XCTAssertEqual(5.formatted(style), "005")
    }

    // MARK: - timeComponent

    func test_timeComponent_alwaysTwoDigits() {
        XCTAssertEqual(0.formatted(NumberFormatting.timeComponent), "00")
        XCTAssertEqual(5.formatted(NumberFormatting.timeComponent), "05")
        XCTAssertEqual(59.formatted(NumberFormatting.timeComponent), "59")
    }

    // MARK: - decimalFormatter (string closure)

    func test_decimalFormatter_formatsValidInput() {
        let formatter = NumberFormatting.decimalFormatter(maxInteger: 5, fractionDigits: 2)
        XCTAssertEqual(formatter("3.14"), "3.14")
    }

    func test_decimalFormatter_invalidInputReturnsZero() {
        let formatter = NumberFormatting.decimalFormatter(maxInteger: 5, fractionDigits: 2)
        XCTAssertEqual(formatter("abc"), "0.00")
    }

    // MARK: - integerFormatter (string closure)

    func test_integerFormatter_formatsValidInputWithPadding() {
        let formatter = NumberFormatting.integerFormatter(minDigits: 3, maxDigits: 3)
        XCTAssertEqual(formatter("5"), "005")
    }

    func test_integerFormatter_invalidInputReturnsZero() {
        let formatter = NumberFormatting.integerFormatter(maxDigits: 5)
        XCTAssertEqual(formatter("abc"), "0")
    }

    // MARK: - parseDecimal

    func test_parseDecimal_validString() {
        XCTAssertEqual(NumberFormatting.parseDecimal("3.14"), 3.14)
    }

    func test_parseDecimal_invalidStringReturnsNil() {
        XCTAssertNil(NumberFormatting.parseDecimal("abc"))
    }

    // MARK: - parseInteger

    func test_parseInteger_validString() {
        XCTAssertEqual(NumberFormatting.parseInteger("42"), 42)
    }

    func test_parseInteger_invalidStringReturnsNil() {
        XCTAssertNil(NumberFormatting.parseInteger("abc"))
    }

    func test_parseInteger_decimalStringTruncatesToInteger() {
        // NumberFormatter fallback truncates the fractional part
        XCTAssertEqual(NumberFormatting.parseInteger("3.14"), 3)
    }

    // MARK: - Double / Int convenience extensions

    func test_double_to2DP() {
        XCTAssertEqual((3.14159).to2DP, "3.14")
    }

    func test_double_to1DP() {
        XCTAssertEqual((3.78).to1DP, "3.8")
    }

    func test_int_asTimeComponent() {
        XCTAssertEqual(5.asTimeComponent, "05")
    }
}
