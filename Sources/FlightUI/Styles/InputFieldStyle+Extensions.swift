import SwiftUI

public extension TextFieldStyle where Self == DefaultTextFieldStyle {
    static var `default`: InputFieldStyle {
        return InputFieldStyle(.default)
    }

    static var advisory: InputFieldStyle {
        return InputFieldStyle(.advisory)
    }

    static var nominal: InputFieldStyle {
        return InputFieldStyle(.nominal)
    }

    static var caution: InputFieldStyle {
        return InputFieldStyle(.caution)
    }

    static var warning: InputFieldStyle {
        return InputFieldStyle(.warning)
    }
}
