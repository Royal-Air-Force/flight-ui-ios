import SwiftUI

public struct InputFieldConfiguration {
    let formatter: NumberFormatter?
    let valueType: TextFieldValueType
    let size: TextFieldSize
    let alignment: TextAlignment
    let useThemeStyling: Bool
    let bordered: Bool
    let staticText: Bool

    public init(
        formatter: NumberFormatter? = nil,
        valueType: TextFieldValueType = .text,
        size: TextFieldSize = .infinity,
        alignment: TextAlignment = .leading,
        useThemeStyling: Bool = true,
        bordered: Bool = false,
        staticText: Bool = false
    ) {
        self.formatter = formatter
        self.valueType = valueType
        self.size = size
        self.alignment = alignment
        self.useThemeStyling = useThemeStyling
        self.bordered = bordered
        self.staticText = staticText
    }
}

extension InputFieldConfiguration {
    public static var plain: InputFieldConfiguration {
        InputFieldConfiguration(formatter: nil,
                                valueType: .text,
                                size: .infinity,
                                alignment: .leading,
                                useThemeStyling: true,
                                bordered: false)
    }
}
