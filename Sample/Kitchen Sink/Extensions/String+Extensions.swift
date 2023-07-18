extension String {
    var isEmptyTrimmed: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
