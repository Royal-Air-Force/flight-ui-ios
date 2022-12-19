import SwiftUI

public class ValidationContext: ObservableObject {
    public typealias Validator = (String, ValidationMode) -> ValidationStatus

    let validator: Validator?

    @Binding var status: ValidationStatus

    public init() {
        self.validator = nil
        self._status = Binding.constant(ValidationStatus.valid)
    }

    public init(validator: @escaping Validator, status: Binding<ValidationStatus>) {
        self.validator = validator
        self._status = status
    }
}

public struct ValidationContextEnvironmentKey: EnvironmentKey {
    public static var defaultValue: ValidationContext = .init()
}

extension EnvironmentValues {
    var validationContext: ValidationContext {
        get { self[ValidationContextEnvironmentKey.self] }
        set { self[ValidationContextEnvironmentKey.self] = newValue }
    }
}

extension View {
    func validationContext(_ context: ValidationContext) -> some View {
        environment(\.validationContext, context)
    }
}
