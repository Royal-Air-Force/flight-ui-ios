import XCTest
import SwiftUI

import ViewInspector

@testable import FlightUI

class ButtonStylesTests: XCTestCase {
    func test_primaryButton() throws {
        let view = Button(action: { }) {
            Text("Primary")
        }
        .buttonStyle(.primary)

        let button = try view.inspect().button()
        let caption = try button.labelView().text().string()

        XCTAssertEqual(caption, "Primary")
    }
}
