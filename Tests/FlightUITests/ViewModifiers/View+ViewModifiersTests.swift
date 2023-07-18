import XCTest
import SwiftUI

import ViewInspector

@testable import FlightUI

class StaticTextViewModifersTests: XCTestCase {
    func test_when_modifiesView_whenBoolCondition_isTrue() throws {
        let view = Text("")
            .when(true) { view in
                view
                    .fontWeight(.bold)
            }

        XCTAssertEqual(try view.inspect().text().attributes().fontWeight(), .bold)
    }

    func test_when_doesNotModifyView_whenBoolCondition_isTrue() throws {
        let view = Text("")
            .when(false) { view in
                view
                    .fontWeight(.bold)
            }

        XCTAssertThrowsError(try view.inspect().text().attributes().fontWeight())
    }

    func test_when_modifiesView_whenFunctionCondition_isTrue() throws {
        let view = Text("")
            .when({ true }) { view in
                view
                    .fontWeight(.bold)
            }

        XCTAssertEqual(try view.inspect().text().attributes().fontWeight(), .bold)
    }

    func test_when_doesNotModifyView_whenFunctionCondition_isTrue() throws {
        let view = Text("")
            .when({ false }) { view in
                view
                    .fontWeight(.bold)
            }

        XCTAssertThrowsError(try view.inspect().text().attributes().fontWeight())
    }
}
