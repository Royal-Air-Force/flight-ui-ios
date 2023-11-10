import SwiftUI

public extension TextFieldStyle where Self == DefaultTextFieldStyle {
    static var `default`: CustomTextFieldStyle {
        return CustomTextFieldStyle(.default)
    }

    static var advisory: CustomTextFieldStyle {
        return CustomTextFieldStyle(.advisory)
    }

    static var nominal: CustomTextFieldStyle {
        return CustomTextFieldStyle(.nominal)
    }

    static var caution: CustomTextFieldStyle {
        return CustomTextFieldStyle(.caution)
    }

    static var warning: CustomTextFieldStyle {
        return CustomTextFieldStyle(.warning)
    }
}
