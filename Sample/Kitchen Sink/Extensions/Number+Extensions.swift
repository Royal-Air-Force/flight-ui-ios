//
//  Number+Extensions.swift
//  flight-ui-ios
//
//  Created by Appivate 2024
//

import Foundation

extension Double {
    func toDecimalString(decimalPlaces: Int) -> String {
        return String(format: "%.\(decimalPlaces)f", self)
    }
}

extension Decimal {
    func toDecimalString() -> String {
        let roundedValue = getNSDecimalNumber()
        return String(format: "%.2f", roundedValue)
    }

    private func getNSDecimalNumber() -> NSDecimalNumber {
        let roundingHandler = NSDecimalNumberHandler(
            roundingMode: .plain,
            scale: 2,
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: false
        )
        return NSDecimalNumber(decimal: self).rounding(accordingToBehavior: roundingHandler)
    }
}
