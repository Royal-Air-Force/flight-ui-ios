import Foundation

// MARK: - Regex Filter

public enum RegexFilter: Sendable {
    case integerOnly
    case doubleOnly
    case letterOnly
    case noDigits
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

// MARK: - Unbound Selection Enum

public protocol UnboundSelectionEnum: CaseIterable, CustomStringConvertible, Sendable {
    static func custom(string: String) -> Self
}
