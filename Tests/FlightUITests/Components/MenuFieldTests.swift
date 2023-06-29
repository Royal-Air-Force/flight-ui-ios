import XCTest
import SwiftUI

import ViewInspector

@testable import FlightUI

class MenuFieldTests: XCTestCase {
    
    // MARK: - Menu Field -
    
    func test_menuField_givenSelection_thenLabelTitleIsSelection() throws {
        // given
        let options = ["Thor", "Iron Man", "Captain America"]
        let selection = Binding<String>(wrappedValue: "Iron Man")
        let sut = MenuField(selection: selection, options: options).environmentObject(Theme())
        
        // then
        let selectionLabelString = try sut.inspect().view(MenuField<Swift.String>.self).menu().labelView().hStack().text(0).string()
        XCTAssertEqual(selectionLabelString, "Iron Man")
    }
    
    
    func test_menuField_givenSelection_whenSelectionChanged_thenCorrectlyUpdatesLabel() throws {
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
        let theme = Theme()
        let actualAttributes = try sut.inspect().view(MenuField<Swift.String>.self).menu().labelView().hStack().text(0).attributes()
        let expectedAttributes = try Text("").font(theme.typography.body).environmentObject(theme).inspect().text(0).attributes()
        XCTAssertEqual(try actualAttributes.font(), try expectedAttributes.font())
        XCTAssertEqual(try actualAttributes.foregroundColor(), try expectedAttributes.foregroundColor())
    }
    
    // MARK: - Optional Menu Field -
    
    func test_optionalMenuField_givenSelectionNil_thenLabelTitleIsSelect() throws {
        // given
        let options = ["Thor", "Iron Man", "Captain America"]
        let selection = Binding<String?>(wrappedValue: nil)
        let sut = OptionalMenuField(selection: selection, options: options).environmentObject(Theme())
        
        // then
        let selectionLabelString = try sut.inspect().view(OptionalMenuField<Swift.String>.self).menu().labelView().hStack().text(0).string()
        XCTAssertEqual(selectionLabelString, "Select")
    }
    
    func test_optionalMenuField_givenSelectionNilAndPlaceholderGiven_thenLabelTitleIsPlaceholder() throws {
        // given
        let options = ["Thor", "Iron Man", "Captain America"]
        let selection = Binding<String?>(wrappedValue: nil)
        let sut = OptionalMenuField(selection: selection, options: options, placeholder: "Choose one").environmentObject(Theme())
        
        // then
        let selectionLabelString = try sut.inspect().view(OptionalMenuField<Swift.String>.self).menu().labelView().hStack().text(0).string()
        XCTAssertEqual(selectionLabelString, "Choose one")
    }
    
    func test_optionalMenuField_givenSelection_thenLabelTitleIsSelection() throws {
        // given
        let options = ["Thor", "Iron Man", "Captain America"]
        let selection = Binding<String?>(wrappedValue: "Iron Man")
        let sut = OptionalMenuField(selection: selection, options: options, placeholder: "Choose one").environmentObject(Theme())
        
        // then
        let selectionLabelString = try sut.inspect().view(OptionalMenuField<Swift.String>.self).menu().labelView().hStack().text(0).string()
        XCTAssertEqual(selectionLabelString, "Iron Man")
    }
    
    func test_optionalMenuField_givenSelection_whenSelectionChanged_thenCorrectlyUpdatesLabel() throws {
        // given
        let options = ["Thor", "Iron Man", "Captain America"]
        let selection = Binding<String?>(wrappedValue: "Iron Man")
        let sut = OptionalMenuField(selection: selection, options: options).environmentObject(Theme())

        // when
        try sut.inspect().view(OptionalMenuField<Swift.String>.self).menu().picker(0).select(value: Optional("Thor"))
        
        // then
        let selectionLabelString = try sut.inspect().view(OptionalMenuField<Swift.String>.self).menu().labelView().hStack().text(0).string()
        XCTAssertEqual(selectionLabelString, "Thor")
    }
    
    func test_optionalMenuField_givenOptionalMenuFieldWithNonNilSelection_thenLabelIsOfInputTypography() throws {
        // given
        let options = ["Thor", "Iron Man", "Captain America"]
        let selection = Binding<String?>(wrappedValue: "Iron Man")
        let sut = OptionalMenuField(selection: selection, options: options).environmentObject(Theme())
        
        // then
        let theme = Theme()
        let actualAttributes = try sut.inspect().view(OptionalMenuField<Swift.String>.self).menu().labelView().hStack().text(0).attributes()
        let expectedAttributes = try Text("").font(theme.typography.body).environmentObject(theme).inspect().text(0).attributes()
        XCTAssertEqual(try actualAttributes.font(), try expectedAttributes.font())
        XCTAssertEqual(try actualAttributes.foregroundColor(), try expectedAttributes.foregroundColor())
    }
    
    func test_optionalMenuField_givenOptionalMenuFieldWithNilSelection_thenLabelIsOfEmptyFieldTypography() throws {
        // given
        let options = ["Thor", "Iron Man", "Captain America"]
        let selection = Binding<String?>(wrappedValue: nil)
        let sut = OptionalMenuField(selection: selection, options: options).environmentObject(Theme())
        
        // then
        let theme = Theme()
        let actualAttributes = try sut.inspect().view(OptionalMenuField<Swift.String>.self).menu().labelView().hStack().text(0).attributes()
        let expectedAttributes = try Text("").font(theme.typography.body).environmentObject(theme).inspect().text(0).attributes()
        XCTAssertEqual(try actualAttributes.font(), try expectedAttributes.font())
        XCTAssertEqual(try actualAttributes.foregroundColor(), try expectedAttributes.foregroundColor())
    }
    
    func test_optionalMenuField_givenSelectionNil_whenSelectionChanged_thenCorrectlyUpdatesTypograhy() throws {
        // given
        let options = ["Thor", "Iron Man", "Captain America"]
        let selection = Binding<String?>(wrappedValue: nil)
        let sut = OptionalMenuField(selection: selection, options: options).environmentObject(Theme())
        
        let theme = Theme()
        var actualAttributes = try sut.inspect().view(OptionalMenuField<Swift.String>.self).menu().labelView().hStack().text(0).attributes()
        var expectedAttributes = try Text("").font(theme.typography.body).environmentObject(theme).inspect().text(0).attributes()
        XCTAssertEqual(try actualAttributes.font(), try expectedAttributes.font())
        XCTAssertEqual(try actualAttributes.foregroundColor(), try expectedAttributes.foregroundColor())

        // when
        try sut.inspect().view(OptionalMenuField<Swift.String>.self).menu().picker(0).select(value: Optional("Captain America"))
        
        // then
        actualAttributes = try sut.inspect().view(OptionalMenuField<Swift.String>.self).menu().labelView().hStack().text(0).attributes()
        expectedAttributes = try Text("").font(theme.typography.body).environmentObject(theme).inspect().text(0).attributes()
        XCTAssertEqual(try actualAttributes.font(), try expectedAttributes.font())
        XCTAssertEqual(try actualAttributes.foregroundColor(), try expectedAttributes.foregroundColor())
    }
}
