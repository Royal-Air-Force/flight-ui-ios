public protocol UnboundSelectionEnum: CaseIterable, CustomStringConvertible {

    static func custom(string: String) -> Self

}
