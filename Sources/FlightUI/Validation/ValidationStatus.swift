import SwiftUI

public enum ValidationStatus: Equatable {
    case indeterminate
    case valid(value: String? = nil)
    case warning(message: String)
    case error(message: String)
    
    public var color: Color {
        switch self {
        case .indeterminate:
            return .flightWhite
        case .valid:
            return .flightWhite
        case .warning:
            return .flightYellow
        case .error:
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
