import SwiftUI

internal class InputFieldDefaults {
    static let disabledOpacity: CGFloat = 0.38
    static let stateBackgroundOpacity: CGFloat = 0.08
    static let hintOpacity: CGFloat = 0.54
}

public enum InputFieldState {
    case `default`
    case advisory
    case nominal
    case caution
    case warning
}

public struct InputFieldConfig {
    var fontColor: Color?
    var fontStyle: FontStyle?
    var backgroundColor: Color?
    var cornerRadius: CGFloat?
    var borderColor: Color?
    
    public init(fontColor: Color? = nil, fontStyle: FontStyle? = nil, backgroundColor: Color? = nil, cornerRadius: CGFloat? = nil, borderColor: Color? = nil) {
        self.fontColor = fontColor
        self.fontStyle = fontStyle
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
    }
}
