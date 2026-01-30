import Foundation

// MARK: - Number Formatting

public enum NumberFormatting {

    // MARK: - Format Styles

    /// Creates a decimal format style with specified precision.
    ///
    /// - Parameters:
    ///   - maxInteger: Maximum number of integer digits (excess digits are truncated)
    ///   - fractionDigits: Exact number of fraction digits to display
    /// - Returns: A configured FloatingPointFormatStyle
    ///
    public static func decimal(
        maxInteger: Int,
        fractionDigits: Int
    ) -> FloatingPointFormatStyle<Double> {
        .number
            .precision(.integerAndFractionLength(
                integerLimits: 1...maxInteger,
                fractionLimits: fractionDigits...fractionDigits
            ))
            .grouping(.never)
            .decimalSeparator(strategy: .always)
    }

    /// Creates a decimal format style with flexible fraction digits.
    ///
    /// - Parameters:
    ///   - maxInteger: Maximum number of integer digits
    ///   - minFraction: Minimum number of fraction digits
    ///   - maxFraction: Maximum number of fraction digits
    /// - Returns: A configured FloatingPointFormatStyle
    public static func decimal(
        maxInteger: Int,
        minFraction: Int,
        maxFraction: Int
    ) -> FloatingPointFormatStyle<Double> {
        .number
            .precision(.integerAndFractionLength(
                integerLimits: 1...maxInteger,
                fractionLimits: minFraction...maxFraction
            ))
            .grouping(.never)
            .decimalSeparator(strategy: .always)
    }

    /// Creates an integer format style with specified padding.
    ///
    /// - Parameters:
    ///   - minDigits: Minimum digits (pads with leading zeros)
    ///   - maxDigits: Maximum digits (truncates excess)
    /// - Returns: A configured IntegerFormatStyle
    ///
    ///
    public static func integer(
        minDigits: Int = 1,
        maxDigits: Int
    ) -> IntegerFormatStyle<Int> {
        .number
            .precision(.integerLength(minDigits...maxDigits))
            .grouping(.never)
    }

    /// Format style for time components (hours, minutes, seconds).
    /// Always displays exactly 2 digits with leading zero padding.
    ///
    public static var timeComponent: IntegerFormatStyle<Int> {
        integer(minDigits: 2, maxDigits: 2)
    }

    // MARK: - String Formatters (for InputField)

    /// Creates a formatting closure suitable for InputField's formatter parameter.
    ///
    /// This closure takes a string input, parses it as a Double, formats it,
    /// and returns the formatted string. Invalid input returns "0.00" (or equivalent).
    ///
    /// - Parameters:
    ///   - maxInteger: Maximum integer digits
    ///   - fractionDigits: Exact number of fraction digits
    /// - Returns: A closure that formats string input
    ///
    public static func decimalFormatter(
        maxInteger: Int,
        fractionDigits: Int
    ) -> @Sendable (String) -> String {
        let style = decimal(maxInteger: maxInteger, fractionDigits: fractionDigits)
        return { input in
            guard let value = Double(input) else {
                return 0.0.formatted(style)
            }
            return value.formatted(style)
        }
    }

    /// Creates an integer formatting closure for InputField.
    ///
    /// - Parameters:
    ///   - minDigits: Minimum digits (pads with zeros)
    ///   - maxDigits: Maximum digits
    /// - Returns: A closure that formats string input as an integer
    public static func integerFormatter(
        minDigits: Int = 1,
        maxDigits: Int
    ) -> @Sendable (String) -> String {
        let style = integer(minDigits: minDigits, maxDigits: maxDigits)
        return { input in
            guard let value = Int(input) else {
                return 0.formatted(style)
            }
            return value.formatted(style)
        }
    }

    // MARK: - Parsing

    /// Parses a formatted decimal string back to a Double.
    ///
    /// Handles locale-specific decimal separators.
    ///
    /// - Parameter string: The formatted string to parse
    /// - Returns: The parsed Double, or nil if parsing fails
    public static func parseDecimal(_ string: String) -> Double? {
        // Use the standard Double initializer which handles basic parsing
        if let value = Double(string) {
            return value
        }
        // Fallback: try with NumberFormatter for locale-aware parsing
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)?.doubleValue
    }

    /// Parses a formatted integer string back to an Int.
    ///
    /// - Parameter string: The formatted string to parse
    /// - Returns: The parsed Int, or nil if parsing fails
    public static func parseInteger(_ string: String) -> Int? {
        // Use standard Int initializer
        if let value = Int(string) {
            return value
        }
        // Fallback: try with NumberFormatter for locale-aware parsing
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter.number(from: string)?.intValue
    }
}

// MARK: - Convenience Extensions

public extension Double {
    /// Formats the double with specified decimal precision.
    ///
    /// - Parameters:
    ///   - maxInteger: Maximum integer digits
    ///   - fractionDigits: Number of fraction digits
    /// - Returns: Formatted string
    func formatted(maxInteger: Int, fractionDigits: Int) -> String {
        self.formatted(NumberFormatting.decimal(maxInteger: maxInteger, fractionDigits: fractionDigits))
    }

    /// Formats the double to exactly 2 decimal places.
    var to2DP: String {
        formatted(maxInteger: 10, fractionDigits: 2)
    }

    /// Formats the double to exactly 1 decimal place.
    var to1DP: String {
        formatted(maxInteger: 10, fractionDigits: 1)
    }
}

public extension Int {
    /// Formats the integer with zero-padding.
    ///
    /// - Parameters:
    ///   - minDigits: Minimum digits (pads with zeros)
    ///   - maxDigits: Maximum digits
    /// - Returns: Formatted string
    func formatted(minDigits: Int, maxDigits: Int) -> String {
        self.formatted(NumberFormatting.integer(minDigits: minDigits, maxDigits: maxDigits))
    }

    /// Formats as a two-digit time component (e.g., "05" for 5).
    var asTimeComponent: String {
        self.formatted(NumberFormatting.timeComponent)
    }
}

// MARK: - Legacy Compatibility (Optional - Remove if not needed)

/// Legacy NumberFormatter-based API for backwards compatibility.
///
/// **Deprecated:** Prefer the FormatStyle-based methods above.
/// This is provided only for gradual migration.
@available(*, deprecated, message: "Use NumberFormatting.decimal() or NumberFormatting.integer() instead")
public extension Formatter {
    static func decimal(
        maximumIntegerDigits: Int,
        minimumFractionDigits: Int = 1,
        maximumFractionDigits: Int = 1
    ) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.alwaysShowsDecimalSeparator = true
        formatter.allowsFloats = true
        formatter.groupingSeparator = ""
        formatter.maximumIntegerDigits = maximumIntegerDigits
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits
        return formatter
    }

    static func integer(
        minimumIntegerDigits: Int = 1,
        maximumIntegerDigits: Int = 1
    ) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minimumIntegerDigits = minimumIntegerDigits
        formatter.maximumIntegerDigits = maximumIntegerDigits
        return formatter
    }

    static var timeComponent: NumberFormatter {
        integer(minimumIntegerDigits: 2, maximumIntegerDigits: 2)
    }
}
