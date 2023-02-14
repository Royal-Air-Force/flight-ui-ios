import SwiftUI

public struct InputMessage: View {
    @Environment (\.validationContext) private var context

    @Binding private var status: ValidationStatus

    private let useBinding: Bool

    public init() {
        self.useBinding = false
        self._status = Binding.constant(.indeterminate)
    }

    public init(status: Binding<ValidationStatus>) {
        self.useBinding = true
        self._status = status
    }

    public var body: some View {
        if let message {
            Text(message)
                .foregroundColor(messageColor)
        } else {
            EmptyView()
        }
    }
    private var message: String? {
        switch nearestStatus {

        case .indeterminate, .valid:
            return nil
        case .warning(let message):
            return message
        case .error(let message):
            return message
        }
    }

    private var messageColor: Color {
        switch nearestStatus {
        case .indeterminate, .valid:
            return Color.white
        case .warning:
            return Color.orange
        case .error:
            return Color.red
        }
    }

    private var nearestStatus: ValidationStatus {
        // Prioritise Status passed as an @Binding over any Validation Context
        if useBinding {
            return status
        }

        return context.status
    }
}

struct InputMessage_Previews: PreviewProvider {
    @State static var errorStatus: ValidationStatus = .error(message: "example error message")
    @State static var warningStatus: ValidationStatus = .warning(message: "example error message")
    @State static var validStatus: ValidationStatus = .valid(value: "Value")
    
    static var previews: some View {
        VStack {
            InputMessage()
                .environment(\.validationContext, ValidationContext(validator: { _ , _ in
                    return .indeterminate
                }, status: $errorStatus))
            InputMessage()
                .environment(\.validationContext, ValidationContext(validator: { _ , _ in
                    return .indeterminate
                }, status: $warningStatus))
            InputMessage()
                .environment(\.validationContext, ValidationContext(validator: { _ , _ in
                    return ValidationStatus.valid(value: "")
                }, status: $validStatus))
        }
    }
}
