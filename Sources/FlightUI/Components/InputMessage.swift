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
    private var message: LocalizedStringKey? {
        switch nearestStatus {
        case .valid:
            return nil
        case .warning(let message):
            return message
        case .caution(let message):
            return message
        case .advisory(let message):
            return message
        }
    }

    private var messageColor: Color {
        switch nearestStatus {
        case .valid:
            return theme.validationStatusValid
        case .warning:
            return theme.validationStatusWarning
        case .caution:
            return theme.validationStatusCaution
        case .advisory:
            return theme.validationStatusAdvisory
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
    @State static var cautionStatus: ValidationStatus = .caution(message: "example Caution message")
    @State static var advisoryStatus: ValidationStatus = .advisory(message: "example Advisory message")
    
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
                    }, status: $cautionStatus))
                InputMessage()
                    .environment(\.validationContext, ValidationContext(validator: { _ , _ in
                        return ValidationStatus.valid
                    }, status: $advisoryStatus))
            }
            .environmentObject(Theme())

            VStack {
                InputMessage()
                    .environment(\.validationContext, ValidationContext(validator: { _ , _ in
                        return ValidationStatus.valid
                    }, status: $warningStatus))
                InputMessage()
                    .environment(\.validationContext, ValidationContext(validator: { _ , _ in
                        return ValidationStatus.valid
                    }, status: $cautionStatus))
                InputMessage()
                    .environment(\.validationContext, ValidationContext(validator: { _ , _ in
                        return ValidationStatus.valid
                    }, status: $advisoryStatus))
            }
            .environmentObject(Theme())
        }
    }
}
