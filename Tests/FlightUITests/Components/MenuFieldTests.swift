import XCTest
import SwiftUI

import ViewInspector

@testable import FlightUI

class MenuFieldTests: XCTestCase {

    // MARK: - Menu Field -

    func test_menuField_givenSelection_thenLabelTitleIsSelection() throws {
        // given
        let options = ["Thor", "Iron Man", "Captain America"]
        let selection = Binding<String?>(wrappedValue: "Iron Man")
        let sut = MenuField(selection: selection, options: options).environmentObject(Theme())

        // then
        let selectionLabelString = try sut.inspect().view(MenuField<Swift.String>.self).vStack().menu(1).labelView().hStack().label(0).title().text().string()
        XCTAssertEqual(selectionLabelString, "Iron Man")
    }

    func test_menuField_givenSelection_whenSelectionChanged_thenCorrectlyUpdatesLabel() throws {
        // given
        let options = ["Thor", "Iron Man", "Captain America"]
        let selection = Binding<String?>(wrappedValue: "Iron Man")
        let sut = MenuField(selection: selection, options: options).environmentObject(Theme())

        // when
        try sut.inspect().view(MenuField<Swift.String>.self).vStack().menu(1).picker(0).select(value: Optional("Thor"))

        // then
        let selectionLabelString = try sut.inspect().view(MenuField<Swift.String>.self).vStack().menu(1).labelView().hStack().label(0).title().text().string()
        XCTAssertEqual(selectionLabelString, "Thor")
    }

    func test_menuField_givenMenuField_thenLabelIsOfInputTypography() throws {
        // given
        let options = ["Thor", "Iron Man", "Captain America"]
        let selection = Binding<String?>(wrappedValue: "Iron Man")
        let sut = MenuField(selection: selection, options: options).environmentObject(Theme())

        // then
        let theme = Theme()
        let actualAttributes = try sut.inspect().view(MenuField<Swift.String>.self).vStack().menu(1).labelView().hStack().label(0).title().text().attributes()
        let expectedAttributes = try Text("").fontStyle(theme.font.bodyBold).environmentObject(theme).inspect().text(0).attributes()
        XCTAssertEqual(try actualAttributes.font(), try expectedAttributes.font())
        XCTAssertEqual(try actualAttributes.foregroundColor(), try expectedAttributes.foregroundColor())
    }
}
