import SwiftUI

public enum ValidationStatus: Equatable {
    case valid
    case warning(message: String)
    case error(message: String)
    
    public var color: Color {
        switch self {
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
    @EnvironmentObject private var theme: Theme

    private let validator: ValidationContext.Validator
    private let status: Binding<ValidationStatus>

    fileprivate init(by validator: @escaping ValidationContext.Validator, status: Binding<ValidationStatus>) {
        self.validator = validator
        self.status = status
    }

    public func body(content: Content) -> some View {
        content
            .validationContext(ValidationContext(validator: validator, status: status))
            .clipShape(RoundedRectangle(cornerRadius: theme.textFieldCornerRadius))
            .overlay {
                if status.wrappedValue != .valid {
                    RoundedRectangle(cornerRadius: theme.textFieldCornerRadius)
                        .stroke(Color.flightOrange, lineWidth: theme.staticTextFieldBorderWidth)
                }
            }
    }
}

public extension View {
    func validated(by validator: @escaping ValidationContext.Validator, status: Binding<ValidationStatus>) -> some View {
        modifier(Validation(by: validator, status: status))
    }
}
