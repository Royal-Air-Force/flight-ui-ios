import SwiftUI
import FlightUI

extension Inputs {
    class ViewModel: ObservableObject {
        @Published var textualInput = ""
        @Published var numericalInput = ""
        @Published var errorInput = ""
        @Published var errorInputResult: ValidationStatus = .error(message: "Error Message")

        @Published var selectionInput: SelectionInputTypes = .selectionOne
        @Published var optionalSelectionInput: SelectionInputTypes?
    }
}

extension Inputs.ViewModel {
    func validateError(value: String, mode: ValidationMode) -> ValidationStatus {
        return .error(message: "Error Message 2")
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
