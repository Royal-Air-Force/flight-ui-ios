import SwiftUI

enum ValidationStatus {
    case valid
    case warning(message: String)
    case error(message: String)
    
    var color: Color {
        switch self {
        case .valid:
            return .flightWhite
        case .warning:
            return .flightYellow
        case .error:
            return .flightOrange
        }
    }
}

enum ValidationMode {
    case editing
    case committed
}

struct Validation: ViewModifier {
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func validated(by validator: @escaping ValidationContext.Validator, status: Binding<ValidationStatus>) -> some View {
        modifier(Validation())
            .validationContext(ValidationContext(validator: validator, status: status))
    }
}
