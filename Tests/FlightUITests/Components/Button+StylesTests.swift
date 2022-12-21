import XCTest
import SwiftUI

import ViewInspector

@testable import FlightUI

class ButtonStylesTests: XCTestCase {
    func test_primaryButton() throws {
        let view = Button("Primary", action: {})
            .buttonStyle(.primary)
            .environmentObject(Theme())
        
        let button = try view.inspect().button()
        let caption = try button.labelView().text().string()
        
        XCTAssertEqual(caption, "Primary")
        XCTAssertTrue(try button.buttonStyle() is PrimaryButtonStyle)
    }
    
    func test_secondaryButton() throws {
        let view = Button("Secondary", action: {})
            .buttonStyle(.secondary)
            .environmentObject(Theme())
        
        let button = try view.inspect().button()
        let caption = try button.labelView().text().string()
        
        XCTAssertEqual(caption, "Secondary")
        XCTAssertTrue(try button.buttonStyle() is SecondaryButtonStyle)
    }
    
    func test_tertiaryButton() throws {
        let view = Button("Tertiary", action: {})
            .buttonStyle(.tertiary)
            .environmentObject(Theme())
        
        let button = try view.inspect().button()
        let caption = try button.labelView().text().string()
        
        XCTAssertEqual(caption, "Tertiary")
        XCTAssertTrue(try button.buttonStyle() is TertiaryButtonStyle)
    }
}
