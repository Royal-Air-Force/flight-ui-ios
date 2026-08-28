//
//  RegexFilter.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

public enum RegexFilter {
    case integerOnly, doubleOnly, letterOnly, noDigits
    case signedIntegerOnly, signedDoubleOnly
    case custom(String)

    public var regex: String {
        switch self {
        case .integerOnly:
            return "[0-9]"
        case .doubleOnly:
            return "[0-9.]"
        case .signedIntegerOnly:
            return "[-0-9]"
        case .signedDoubleOnly:
            return "[-0-9.]"
        case .letterOnly:
            return "[A-Za-z]"
        case .noDigits:
            return "[^0-9]"
        case .custom(let customValue):
            return customValue
        }
    }
}
