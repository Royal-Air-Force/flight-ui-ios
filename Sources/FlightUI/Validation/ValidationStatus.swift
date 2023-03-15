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
    private let cornerRadius: Double

    fileprivate init(by validator: @escaping ValidationContext.Validator, status: Binding<ValidationStatus>, cornerRadius: Double?) {
        self.validator = validator
        self.status = status
        self.cornerRadius = cornerRadius ?? CornerRadius().default
    }

    public func body(content: Content) -> some View {
        content
            .validationContext(ValidationContext(validator: validator, status: status))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay {
                if status.wrappedValue != .valid {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.flightOrange, lineWidth: theme.staticTextFieldBorderWidth)
                }
            }
    }
}

public extension View {
    func validated(by validator: @escaping ValidationContext.Validator, status: Binding<ValidationStatus>, cornerRadius: Double?) -> some View {
        modifier(Validation(by: validator, status: status, cornerRadius: cornerRadius))
    }
}
