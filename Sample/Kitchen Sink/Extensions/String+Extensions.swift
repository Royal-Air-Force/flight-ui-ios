import Foundation

extension String {
    var isEmptyTrimmed: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func toDouble() -> Double {
        return Double(self) ?? 0.0
    }
    
    func toDecimal() -> Decimal {
        return Decimal(string: self) ?? 0.0
    }
}
