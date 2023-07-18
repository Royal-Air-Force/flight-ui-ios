import SwiftUI
import FlightUI

extension Inputs {
    class ViewModel: ObservableObject {
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
