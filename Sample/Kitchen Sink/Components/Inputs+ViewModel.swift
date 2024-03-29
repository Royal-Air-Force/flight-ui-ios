//
//  Inputs+ViewModel.swift
//  Flight UI - Kitchen Sink Sample
//
//  Created by Appivate 2023
//

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
        @Published var bottomLabel = "Bottom Label"
        @Published var formatInput = ""
        @Published var debounceInput = ""
        @Published var debounceAdvisoryLabel = defaultDebounceAdvisoryLabel
        @Published var keyboardInput = ""

        @Published var boundSelectionInput: BoundSelectionTypes?
        @Published var unboundSelectionInput: UnboundDefaultSelectionTypes?

        func nominalState() -> InputAlertingState {
            return nominalStateInput.isEmpty ? .default : .nominal
        }

        func nominalAdvisory() -> BottomLabelConfig {
            return BottomLabelConfig(
                nominalStateInput.isEmpty ? "Required" : "Extra info",
                state: nominalStateInput.isEmpty ? .caution : .default
            )
        }

        func cautionState() -> InputAlertingState {
            return cautionStateInput.isEmpty ? .default : .caution
        }

        func cautionAdvisory() -> BottomLabelConfig {
            return BottomLabelConfig("Extra info", state: cautionState())
        }

        func warningState() -> InputAlertingState {
            return warningStateInput.isEmpty ? .default : .warning
        }

        func warningAdvisory() -> BottomLabelConfig {
            return BottomLabelConfig("Extra info", state: warningState())
        }

        func boundSelectionState() -> InputAlertingState {
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

        func unboundSelectionState() -> InputAlertingState {
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
