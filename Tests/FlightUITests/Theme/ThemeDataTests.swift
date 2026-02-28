import XCTest
import SwiftUI

@testable import FlightUI

final class ThemeDataTests: XCTestCase {

    // MARK: - Factories

    func test_darkTheme_hasCorrectBaseScheme() {
        XCTAssertEqual(ThemeData.dark.baseScheme, .dark)
    }

    func test_lightTheme_hasCorrectBaseScheme() {
        XCTAssertEqual(ThemeData.light.baseScheme, .light)
    }

    // MARK: - withColors / withSpacing / withSize / withRadius / withTypography
    // Each withX method replaces its target and preserves all other properties.
    // The preserve behaviour is tested once (withColors); subsequent tests verify replacement only.

    func test_withColors_preservesAllOtherFields() {
        let modified = ThemeData.dark.withColors(.light)
        XCTAssertEqual(modified.baseScheme, ThemeData.dark.baseScheme)
        XCTAssertEqual(modified.spacing.grid1x, ThemeData.dark.spacing.grid1x)
        XCTAssertEqual(modified.size.medium, ThemeData.dark.size.medium)
        XCTAssertEqual(modified.radius.medium, ThemeData.dark.radius.medium)
        XCTAssertEqual(modified.typography.body.size, ThemeData.dark.typography.body.size)
    }

    func test_withSpacing_replacesSpacing() {
        let modified = ThemeData.dark.withSpacing(.compact)
        XCTAssertEqual(modified.spacing.grid1x, ThemeSpacingData.compact.grid1x)
    }

    func test_withSize_replacesSize() {
        let modified = ThemeData.dark.withSize(.compact)
        XCTAssertEqual(modified.size.medium, ThemeSizeData.compact.medium)
    }

    func test_withRadius_replacesRadius() {
        let modified = ThemeData.dark.withRadius(.rounded)
        XCTAssertEqual(modified.radius.medium, ThemeRadiusData.rounded.medium)
    }

    func test_withTypography_replacesTypography() {
        let modified = ThemeData.dark.withTypography(.standard)
        XCTAssertEqual(modified.typography.body.size, ThemeTypographyData.standard.body.size)
    }

    // MARK: - scaled(by:)

    func test_scaled_scalesSpacing() {
        let base = ThemeData.dark
        let scaled = base.scaled(by: 2.0)
        XCTAssertEqual(scaled.spacing.grid1x, base.spacing.grid1x * 2.0)
    }

    func test_scaled_scalesSize() {
        let base = ThemeData.dark
        let scaled = base.scaled(by: 2.0)
        XCTAssertEqual(scaled.size.medium, base.size.medium * 2.0)
    }

    func test_scaled_scalesRadius() {
        let base = ThemeData.dark
        let scaled = base.scaled(by: 2.0)
        XCTAssertEqual(scaled.radius.medium, base.radius.medium * 2.0)
    }

    func test_scaled_scalesTypography() {
        let base = ThemeData.dark
        let scaled = base.scaled(by: 2.0)
        XCTAssertEqual(scaled.typography.body.size, base.typography.body.size * 2.0)
    }

    func test_scaled_preservesBaseScheme() {
        XCTAssertEqual(ThemeData.dark.scaled(by: 1.5).baseScheme, ThemeData.dark.baseScheme)
    }

    func test_scaled_doesNotScaleDivider() {
        let base = ThemeData.dark
        XCTAssertEqual(base.scaled(by: 2.0).size.divider, base.size.divider)
    }

    // MARK: - inverted

    func test_inverted_darkBecomesLight() {
        XCTAssertEqual(ThemeData.dark.inverted.baseScheme, .light)
    }

    func test_inverted_lightBecomesDark() {
        XCTAssertEqual(ThemeData.light.inverted.baseScheme, .dark)
    }

    func test_inverted_preservesNonColorProperties() {
        let base = ThemeData.dark
        let inverted = base.inverted
        XCTAssertEqual(inverted.spacing.grid1x, base.spacing.grid1x)
        XCTAssertEqual(inverted.size.medium, base.size.medium)
        XCTAssertEqual(inverted.radius.medium, base.radius.medium)
        XCTAssertEqual(inverted.typography.body.size, base.typography.body.size)
    }

    func test_inverted_isItsOwnInverse() {
        XCTAssertEqual(ThemeData.dark.inverted.inverted.baseScheme, .dark)
    }

    // MARK: - ThemeRadiusData.calculateInnerRadius

    func test_calculateInnerRadius_subtractsHalfPadding() {
        let radius = ThemeRadiusData.standard
        XCTAssertEqual(radius.calculateInnerRadius(outerRadius: 20, outerPadding: 16), 12)
    }

    func test_calculateInnerRadius_clampsToMinimumOfOne() {
        let radius = ThemeRadiusData.standard
        // outerRadius - outerPadding/2 would be 0 or negative; must clamp to 1
        XCTAssertEqual(radius.calculateInnerRadius(outerRadius: 4, outerPadding: 16), 1)
    }

    // MARK: - FontStyle

    func test_fontStyle_scaled_scalesSizeAndLineSpacing() {
        let base = FontStyle.body
        let scaled = base.scaled(by: 2.0)
        XCTAssertEqual(scaled.size, base.size * 2.0)
        XCTAssertEqual(scaled.lineSpacing, base.lineSpacing * 2.0)
    }

    func test_fontStyle_scaled_preservesWeightAndDesign() {
        let base = FontStyle.bodyBold
        let scaled = base.scaled(by: 1.5)
        XCTAssertEqual(scaled.weight, base.weight)
        XCTAssertEqual(scaled.design, base.design)
    }

    func test_fontStyle_withColor_changesColor() {
        let updated = FontStyle.body.withColor(.red)
        XCTAssertEqual(updated.foregroundColor, .red)
    }

    func test_fontStyle_withColor_preservesOtherProperties() {
        let base = FontStyle.body
        let updated = base.withColor(.red)
        XCTAssertEqual(updated.size, base.size)
        XCTAssertEqual(updated.weight, base.weight)
        XCTAssertEqual(updated.lineSpacing, base.lineSpacing)
    }
}
