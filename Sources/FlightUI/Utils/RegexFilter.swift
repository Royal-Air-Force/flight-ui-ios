//
//  RegexFilter.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

public enum RegexFilter {
    case integerOnly, doubleOnly, letterOnly, noDigits
    case custom(String)

    public var regex: String {
        switch self {
        case .integerOnly:
            return "[^0-9]"
        case .doubleOnly:
            return "[^0-9.]"
        case .letterOnly:
            return "[^A-Z^a-z]"
        case .noDigits:
            return "[0-9]"
        case .custom(let customValue):
            return customValue
        }
    }
}
