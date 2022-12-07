import SwiftUI

public extension Color {
    // Notes
    // Cant use primary and secondary here, conflicts with SwiftUI Colors.
    static let ballisticPrimary = Color("primary", bundle: .module)
    static let ballisticSecondary = Color("secondary", bundle: .module)
    static let neutralBlack = Color("neutralBlack", bundle: .module)
    static let neutralDarkGray = Color("neutralDarkGray", bundle: .module)
    static let neatralLightGray = Color("neatralLightGray", bundle: .module)
    static let neutralBlue = Color("neutralBlue", bundle: .module)
    static let warning = Color("warning", bundle: .module)
    static let error = Color("error", bundle: .module)
}
