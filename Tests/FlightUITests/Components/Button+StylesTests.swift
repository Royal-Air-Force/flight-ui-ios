import XCTest
import SwiftUI

import ViewInspector

@testable import FlightUI

class ButtonStylesTests: XCTestCase {
    func test_filledButton() throws {
        let view = Button("Filled", action: {})
            .buttonStyle(.filled)
            .environmentObject(Theme())

        let button = try view.inspect().button()
        let caption = try button.labelView().text().string()

        XCTAssertEqual(caption, "Filled")
        XCTAssertTrue(try button.buttonStyle() is FilledButtonStyle)
    }

    func test_tonalButton() throws {
        let view = Button("Tonal", action: {})
            .buttonStyle(.tonal)
            .environmentObject(Theme())

        let button = try view.inspect().button()
        let caption = try button.labelView().text().string()

        XCTAssertEqual(caption, "Tonal")
        XCTAssertTrue(try button.buttonStyle() is TonalButtonStyle)
    }

    func test_outlineButton() throws {
        let view = Button("Outline", action: {})
            .buttonStyle(.outline)
            .environmentObject(Theme())

        let button = try view.inspect().button()
        let caption = try button.labelView().text().string()

        XCTAssertEqual(caption, "Outline")
        XCTAssertTrue(try button.buttonStyle() is OutlineButtonStyle)
    }

    func test_textButton() throws {
        let view = Button("Text", action: {})
            .buttonStyle(.text)
            .environmentObject(Theme())

        let button = try view.inspect().button()
        let caption = try button.labelView().text().string()

        XCTAssertEqual(caption, "Text")
        XCTAssertTrue(try button.buttonStyle() is TextButtonStyle)
    }
}
