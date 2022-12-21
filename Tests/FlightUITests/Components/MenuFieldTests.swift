import XCTest
import SwiftUI

import ViewInspector

@testable import FlightUI

extension MenuField: Inspectable {}
extension Input: Inspectable {}

class MenuFieldTests: XCTestCase {
    func test_menuField_givenSelectionIronMan_thenLabelIsIronMan() throws {
        // given
        let options = ["Thor", "Iron Man", "Captain America"]
        let selection = Binding<String>(wrappedValue: "Iron Man")
        let sut = MenuField(selection: selection, options: options).environmentObject(Theme())
        
        // then
        let selectionLabelString = try sut.inspect().view(MenuField<Swift.String>.self).menu().labelView().hStack().text(0).string()
        XCTAssertEqual(selectionLabelString, "Iron Man")
    }
    
    
    func test_menuField_givenSelectionIronMan_whenThorSelected_thenCorrectlyUpdatesLabel() throws {
        // given
        let options = ["Thor", "Iron Man", "Captain America"]
        let selection = Binding<String>(wrappedValue: "Iron Man")
        let sut = MenuField(selection: selection, options: options).environmentObject(Theme())

        // when
        try sut.inspect().view(MenuField<Swift.String>.self).menu().picker(0).select(value: "Thor")
        
        // then
        let selectionLabelString = try sut.inspect().view(MenuField<Swift.String>.self).menu().labelView().hStack().text(0).string()
        XCTAssertEqual(selectionLabelString, "Thor")
    }
    
    func test_menuField_givenMenuField_thenLabelIsOfInputTypography() throws {
        // given
        let options = ["Thor", "Iron Man", "Captain America"]
        let selection = Binding<String>(wrappedValue: "Iron Man")
        let sut = MenuField(selection: selection, options: options).environmentObject(Theme())
        
        // then
        let actualAttributes = try sut.inspect().view(MenuField<Swift.String>.self).menu().labelView().hStack().text(0).attributes()
        let expectedAttributes = try Text("").typography(.input).environmentObject(Theme()).inspect().text(0).attributes()
        XCTAssertEqual(try actualAttributes.font(), try expectedAttributes.font())
    }
}
