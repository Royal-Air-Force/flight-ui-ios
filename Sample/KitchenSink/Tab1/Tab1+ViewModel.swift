import SwiftUI
import FlightUI

extension Tab1 {
    class ViewModel: ObservableObject {
        @Published var textualInput = ""
        @Published var numericalInput = ""
        @Published var numericalInputResult: ValidationStatus = .error(message: "Error Message")
        
        @Published var selectionInput: SelectionInputTypes = .selectionOne
        @Published var optionalSelectionInput: SelectionInputTypes?
        
        @Published var isShowingResetAlert = false
    }
}

extension Tab1.ViewModel {
    func reset() {
        textualInput = ""
        numericalInput = ""
    }
}

extension Tab1.ViewModel {
    func validateNumericalInput(value: String, mode: ValidationMode) -> ValidationStatus {
        if let doubleValue = Double(value) {
            switch doubleValue {
            case ..<(0):
                return .warning(message: "Below Limit")
            case ...1:
                return .valid
            default:
                return .warning(message: "Warning Message")
            }
        }
        
        return validateRequiredField(value, mode: mode)
    }
}

extension Tab1.ViewModel {
    private func validateRequiredField(_ text: String, mode: ValidationMode) -> ValidationStatus {
        switch mode {
        case .editing where text.isEmptyTrimmed:
            return .valid
        case .committed where text.isEmptyTrimmed:
            return .error(message: "Required")
        default:
            return .error(message: "Invalid input format")
        }
    }
}


extension Tab1.ViewModel {
    enum SelectionInputTypes: String, CaseIterable, CustomStringConvertible {
        case selectionOne = "Option One"
        case selectionTwo = "Option Two"
        case selectionThree = "Option Three"
        
        var description: String {
            return rawValue
        }
    }
    
}
