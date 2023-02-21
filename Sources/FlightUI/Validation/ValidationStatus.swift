import SwiftUI

public enum ValidationStatus: Equatable {
    case valid
    case advisory(message: String)
    case caution(message: String)
    case warning(message: String)
    
    public var color: Color {
        switch self {
        case .valid:
            return .flightWhite
        case .advisory:
            return .flightWhite
        case .caution:
            return .flightYellow
        case .warning:
            return .flightRed
        }
    }
}

public enum ValidationMode {
    case editing
    case committed
}

public struct Validation: ViewModifier {
    public func body(content: Content) -> some View {
        content
    }
}

public extension View {
    func validated(by validator: @escaping ValidationContext.Validator, status: Binding<ValidationStatus>) -> some View {
        modifier(Validation())
            .validationContext(ValidationContext(validator: validator, status: status))
    }
}
