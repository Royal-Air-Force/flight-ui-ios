import SwiftUI

class ValidationContext: ObservableObject {
    typealias Validator = (String, ValidationMode) -> ValidationStatus

    let validator: Validator?

    @Binding var status: ValidationStatus

    init() {
        self.validator = nil
        self._status = Binding.constant(ValidationStatus.valid)
    }

    init(validator: @escaping Validator, status: Binding<ValidationStatus>) {
        self.validator = validator
        self._status = status
    }
}

struct ValidationContextEnvironmentKey: EnvironmentKey {
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
