import SwiftUI
import FlightUI

extension Inputs {
    class ViewModel: ObservableObject {
        @Published var testInput = ""
        @Published var nominalInput = ""
        @Published var textualInput = ""
        @Published var numericalInput = ""
        @Published var advisoryInput = ""
        @Published var advisoryInputResult: ValidationStatus = .advisory(message: "Advisory Message")
        @Published var cautionInput = ""
        @Published var cautionInputResult: ValidationStatus = .caution(message: "Caution Message")
        @Published var warningInput = ""
        @Published var warningInputResult: ValidationStatus = .warning(message: "Warning Message")

        @Published var selectionInput: SelectionInputTypes = .selectionOne
        @Published var optionalSelectionInput: SelectionInputTypes?
        
        @Published var generalDisabled = ""
        @Published var generalHint = ""
        @Published var generalActive = "General"
        @Published var advisoryText = "Advisory"
        @Published var nominalState = "Nominal"
        @Published var cautionState = "Caution"
        @Published var warningState = "Warning"
        @Published var topLabel = "Top Label"
        @Published var advisoryLabel = "Advisory Label"
    }
}

extension Inputs.ViewModel {
    func validateAdvisory(value: String, mode: ValidationMode) -> ValidationStatus {
        return .advisory(message: "Advisory Message")
    }
    func validateCaution(value: String, mode: ValidationMode) -> ValidationStatus {
        return .caution(message: "Caution Message")
    }
    func validateWarning(value: String, mode: ValidationMode) -> ValidationStatus {
        return .warning(message: "Warning Message")
    }
}

extension Inputs.ViewModel {
    enum SelectionInputTypes: String, CaseIterable, CustomStringConvertible {
        case selectionOne = "Option One"
        case selectionTwo = "Option Two"
        case selectionThree = "Option Three"

        var description: String {
            return rawValue
        }
    }

}

//extension Colours {
//    class ViewModel: ObservableObject {
//        @Published var textualInput = ""
//        @Published var numericalInput = ""
//        @Published var numericalInputResult: ValidationStatus = .caution(message: "Caution Message")
//
//        @Published var selectionInput: SelectionInputTypes = .selectionOne
//        @Published var optionalSelectionInput: SelectionInputTypes?
//
//        @Published var isShowingResetAlert = false
//    }
//}
//
//extension Colours.ViewModel {
//    func reset() {
//        textualInput = ""
//        numericalInput = ""
//    }
//}
//
//extension Colours.ViewModel {
//    func validateNumericalInput(value: String, mode: ValidationMode) -> ValidationStatus {
//        if let doubleValue = Double(value) {
//            switch doubleValue {
//            case ..<(0):
//                return .warning(message: "Below Limit")
//            case ...1:
//                return .valid
//            default:
//                return .warning(message: "Warning Message")
//            }
//        }
//
//        return validateRequiredField(value, mode: mode)
//    }
//}
//
//extension Colours.ViewModel {
//    private func validateRequiredField(_ text: String, mode: ValidationMode) -> ValidationStatus {
//        switch mode {
//        case .editing where text.isEmptyTrimmed:
//            return .valid
//        case .committed where text.isEmptyTrimmed:
//            return .caution(message: "Required")
//        default:
//            return .caution(message: "Invalid input format")
//        }
//    }
//}
//
//extension Colours.ViewModel {
//    enum SelectionInputTypes: String, CaseIterable, CustomStringConvertible {
//        case selectionOne = "Option One"
//        case selectionTwo = "Option Two"
//        case selectionThree = "Option Three"
//
//        var description: String {
//            return rawValue
//        }
//    }
//
//}
