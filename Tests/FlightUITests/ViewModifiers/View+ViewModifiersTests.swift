import XCTest
import SwiftUI

import ViewInspector

@testable import FlightUI

class StaticTextViewModifersTests: XCTestCase {
    func test_when_modifiesView_whenCondition_isTrue() throws {
        let view = Text("")
            .when(true) { view in
                view
                    .fontWeight(.bold)
            }

        XCTAssertEqual(try view.inspect().text().attributes().fontWeight(), .bold)
    }

    func test_when_doesNotModifyView_whenCondition_isTrue() throws {
        let view = Text("")
            .when(false) { view in
                view
                    .fontWeight(.bold)
            }

        XCTAssertThrowsError(try view.inspect().text().attributes().fontWeight())
    }
}
