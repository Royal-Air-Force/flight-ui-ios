extension String {
    var isEmptyTrimmed: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

extension Double {
    func toDecimalString(decimalPlaces: Int) -> String {
        return String(format: "%.\(decimalPlaces)f", self)
    }
}
