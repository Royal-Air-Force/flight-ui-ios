import SwiftUI

public struct InputMessage: View {
    @Environment (\.validationContext) private var context
    @EnvironmentObject var theme: Theme

    @Binding private var status: ValidationStatus

    private let useBinding: Bool

    public init() {
        self.useBinding = false
        self._status = Binding.constant(ValidationStatus.valid)
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
            return theme.validationStatusValid
        case .warning:
            return theme.validationStatusWarning
        case .error:
            return theme.validationStatusError
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
    @State static var warningStatus: ValidationStatus = .warning(message: "example Warning message")
    @State static var errorStatus: ValidationStatus = .error(message: "example Error message")
    
    static var previews: some View {
        VStack {
            VStack {
                InputMessage()
                    .environment(\.validationContext, ValidationContext(validator: { _ , _ in
                        return ValidationStatus.valid
                    }, status: $warningStatus))
                InputMessage()
                    .environment(\.validationContext, ValidationContext(validator: { _ , _ in
                        return ValidationStatus.valid
                    }, status: $errorStatus))
            }
            .environmentObject(Theme(validationStatusWarning: .flightOrange,
                                     validationStatusError: .flightRed))

            VStack {
                InputMessage()
                    .environment(\.validationContext, ValidationContext(validator: { _ , _ in
                        return ValidationStatus.valid
                    }, status: $warningStatus))
                InputMessage()
                    .environment(\.validationContext, ValidationContext(validator: { _ , _ in
                        return ValidationStatus.valid
                    }, status: $errorStatus))
            }
            .environmentObject(Theme(validationStatusWarning: .flightGreen,
                                     validationStatusError: .flightBlue))
        }
    }
}
