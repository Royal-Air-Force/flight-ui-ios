import SwiftUI

public struct InputFieldOptionSet: OptionSet {
    public let rawValue: UInt8

    public static let useThemeStyling = InputFieldOptionSet(rawValue: 0x1)
    public static let bordered = InputFieldOptionSet(rawValue: 0x2)
    public static let staticText = InputFieldOptionSet(rawValue: 0x2)

    public static let none = InputFieldOptionSet([])
    public static let all = InputFieldOptionSet([.useThemeStyling, .bordered, .staticText])

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
}

public struct InputFieldConfiguration {
    let formatter: NumberFormatter?
    let valueType: TextFieldValueType
    let size: TextFieldSize
    let alignment: TextAlignment
    let options: InputFieldOptionSet

    private init(
        formatter: NumberFormatter? = nil,
        valueType: TextFieldValueType = .text,
        size: TextFieldSize = .infinity,
        alignment: TextAlignment = .leading,
        options: InputFieldOptionSet = .useThemeStyling
    ) {
        self.formatter = formatter
        self.valueType = valueType
        self.size = size
        self.alignment = alignment
        self.options = options
    }
}

extension InputFieldConfiguration {
    public static var `default`: InputFieldConfiguration {
        return .inputFieldConfiguration(formatter: nil,
                                        valueType: .text,
                                        size: .infinity,
                                        alignment: .leading,
                                        options: .useThemeStyling)
    }

    public static func inputFieldConfiguration(
        formatter: NumberFormatter? = nil,
        valueType: TextFieldValueType = .text,
        size: TextFieldSize = .infinity,
        alignment: TextAlignment = .leading,
        options: InputFieldOptionSet = .useThemeStyling
    ) -> InputFieldConfiguration {
        InputFieldConfiguration(formatter: formatter,
                                valueType: valueType,
                                size: size,
                                alignment: alignment,
                                options: options)
    }
}
