import SwiftUI
import FlightUI

extension Inputs {
    class ViewModel: ObservableObject {
        static let defaultDebounceAdvisoryLabel = "Adds a 2 second delay"

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

        @Published var selectionInput: SelectionInputTypes? = .selectionOne
        @Published var optionalSelectionInput: SelectionInputTypes?
        
        @Published var boundSelectionInput: BoundSelectionTypes? = nil

        @Published var generalDisabled = ""
        @Published var generalHint = ""
        @Published var generalActive = "General"
        @Published var advisoryText = "Advisory"
        @Published var nominalStateInput = "Nominal"
        @Published var cautionStateInput = "Caution"
        @Published var warningStateInput = "Warning"
        @Published var topLabel = "Top Label"
        @Published var advisoryLabel = "Advisory Label"
        @Published var formatInput = ""
        @Published var debounceInput = ""
        @Published var debounceAdvisoryLabel = defaultDebounceAdvisoryLabel
        @Published var keyboardInput = ""

        func nominalState() -> InputFieldState {
            return nominalStateInput.isEmpty ? .default : .nominal
        }

        func nominalAdvisory() -> AdvisoryLabel {
            return AdvisoryLabel(
                nominalStateInput.isEmpty ? "Required" : "Extra info",
                state: nominalStateInput.isEmpty ? .caution : .default
            )
        }

        func cautionState() -> InputFieldState {
            return cautionStateInput.isEmpty ? .default : .caution
        }

        func cautionAdvisory() -> AdvisoryLabel {
            return AdvisoryLabel("Extra info", state: cautionState())
        }

        func warningState() -> InputFieldState {
            return warningStateInput.isEmpty ? .default : .warning
        }

        func warningAdvisory() -> AdvisoryLabel {
            return AdvisoryLabel("Extra info", state: warningState())
        }
        
        func boundSelectionState() -> InputFieldState {
            switch boundSelectionInput {
            case .nominalSelection:
                return .nominal
            case .cautionSelection:
                return .caution
            case .warningSelection:
                return .warning
            default:
                return .default
            }
        }
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
    enum BoundSelectionTypes: String, CaseIterable, CustomStringConvertible {
        case defaultSelection = "Default Selection"
        case nominalSelection = "Nominal Selection"
        case cautionSelection = "Caution Selection"
        case warningSelection = "Warning Selection"
        
        var description: String {
            return rawValue
        }
    }
    
    enum SelectionInputTypes: String, CaseIterable, CustomStringConvertible {
        case selectionOne = "Option One"
        case selectionTwo = "Option Two"
        case selectionThree = "Option Three"

        var description: String {
            return rawValue
        }
    }

}

// extension Colours {
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
// }
//
// extension Colours.ViewModel {
//    func reset() {
//        textualInput = ""
//        numericalInput = ""
//    }
// }
//
// extension Colours.ViewModel {
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
// }
//
// extension Colours.ViewModel {
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
// }
//
// extension Colours.ViewModel {
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
// }
