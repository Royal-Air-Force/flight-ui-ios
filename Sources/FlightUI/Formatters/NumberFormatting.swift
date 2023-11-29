//
//  NumberFormatting.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import Foundation

public enum NumberFormatting {
    case decimal(maximumIntegerDigits: Int, minimumFractionDigits: Int, maximumFractionDigits: Int)
    case integer(minimumIntegerDigits: Int, maximumIntegerDigits: Int)

    var formatter: NumberFormatter {
        switch self {
        case .decimal(let maximumIntegerDigits, let minimumFractionDigits, let maximumFractionDigits):
            let formatter = NumberFormatter()

            formatter.numberStyle = .decimal
            formatter.alwaysShowsDecimalSeparator = true
            formatter.allowsFloats = true
            formatter.groupingSeparator = ""

            formatter.maximumIntegerDigits = maximumIntegerDigits
            formatter.minimumFractionDigits = minimumFractionDigits
            formatter.maximumFractionDigits = maximumFractionDigits

            return formatter

        case .integer(let minimumIntegerDigits, let maximumIntegerDigits):
            let formatter = NumberFormatter()

            formatter.numberStyle = .none
            formatter.minimumIntegerDigits = minimumIntegerDigits
            formatter.maximumIntegerDigits = maximumIntegerDigits

            return formatter
        }
    }
}

public extension Formatter {
    static func decimal(maximumIntegerDigits: Int, minimumFractionDigits: Int = 1, maximumFractionDigits: Int = 1) -> NumberFormatter {
        let formatting: NumberFormatting = .decimal(
            maximumIntegerDigits: maximumIntegerDigits,
            minimumFractionDigits: minimumFractionDigits,
            maximumFractionDigits: maximumFractionDigits)

        return formatting.formatter
    }

    static func integer(minimumIntegerDigits: Int = 1, maximumIntegerDigits: Int = 1) -> NumberFormatter {
        let formatting: NumberFormatting = .integer(
            minimumIntegerDigits: minimumIntegerDigits,
            maximumIntegerDigits: maximumIntegerDigits)

        return formatting.formatter
    }

    static var timeComponent: NumberFormatter {
        let formatting: NumberFormatting = .integer(
            minimumIntegerDigits: 2,
            maximumIntegerDigits: 2)

        return formatting.formatter
    }
}
