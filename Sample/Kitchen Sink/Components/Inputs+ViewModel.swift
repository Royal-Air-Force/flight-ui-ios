import SwiftUI
import FlightUI

extension Inputs {
    class ViewModel: ObservableObject {
        static let defaultDebounceAdvisoryLabel = "Adds a 2 second delay"

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

        @Published var boundSelectionInput: BoundSelectionTypes?
        @Published var unboundSelectionInput: UnboundDefaultSelectionTypes?

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

        func boundSelectionState() -> MenuFieldState {
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

        func unboundSelectionState() -> MenuFieldState {
            switch unboundSelectionInput {
            case .nominalSelection:
                return .nominal
            case .cautionSelection:
                return .caution
            case .warningSelection:
                return .warning
            case .customSelection(let customString):
                if customString == "Error" {
                    return .warning
                } else {
                    return .default
                }
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

    enum UnboundDefaultSelectionTypes: UnboundSelectionEnum {
        static var allCases: [Inputs.ViewModel.UnboundDefaultSelectionTypes] {
            return [.defaultSelection, .nominalSelection, .cautionSelection, .warningSelection]
        }

        case customSelection(String)
        case defaultSelection
        case nominalSelection
        case cautionSelection
        case warningSelection

        var description: String {
            switch self {
            case .defaultSelection:
                return "Default Selection"
            case .nominalSelection:
                return "Nominal Selection"
            case .cautionSelection:
                return "Caution Selection"
            case .warningSelection:
                return "Warning Selection"
            case .customSelection(let customString):
                return customString
            }
        }

        static func custom(string: String) -> Inputs.ViewModel.UnboundDefaultSelectionTypes {
            return .customSelection(string)
        }
    }
}
