//
//  String+Extensions.swift
//  Flight UI - Kitchen Sink Sample
//
//  Created by Appivate 2023
//

extension String {
    var isEmptyTrimmed: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func toDouble() -> Double {
        return Double(self) ?? 0.0
    }
}

extension Double {
    func toDecimalString(decimalPlaces: Int) -> String {
        return String(format: "%.\(decimalPlaces)f", self)
    }
}
