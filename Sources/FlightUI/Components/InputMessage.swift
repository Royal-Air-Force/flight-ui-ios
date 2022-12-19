import SwiftUI

struct InputMessage: View {
    @Environment (\.validationContext) private var context

    @Binding private var status: ValidationStatus

    private let useBinding: Bool

    init() {
        self.useBinding = false
        self._status = Binding.constant(ValidationStatus.valid)
    }

    init(status: Binding<ValidationStatus>) {
        self.useBinding = true
        self._status = status
    }

    var body: some View {
        if let message {
            Text(message)
                .foregroundColor(messageColor)
        } else {
            EmptyView()
        }
    }
    private var message: String? {
        switch nearestStatus {
        case .valid:
            return nil
        case .warning(let message):
            return message
        case .error(let message):
            return message
        }
    }

    private var messageColor: Color {
        switch nearestStatus {
        case .valid:
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
    @State static var status: ValidationStatus = .error(message: "example error message")
    
    static var previews: some View {
        InputMessage()
            .environment(\.validationContext, ValidationContext(validator: { _ , _ in
                return ValidationStatus.valid
            }, status: $status))
    }
}
