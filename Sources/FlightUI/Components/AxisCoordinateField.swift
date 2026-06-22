import SwiftUI
import AviationMaths

// MARK: - Axis Coordinate Field (Internal Generic)

/// Generic internal implementation shared by `LatitudeField` and `LongitudeField`.
///
/// `Value` is `Latitude` or `Longitude`; `Direction` is the corresponding cardinal direction enum.
/// All axis-specific constants (degree ranges, placeholders, max character counts) are injected
/// as parameters, keeping this view free of hard-coded latitude/longitude assumptions.
///
struct AxisCoordinateField<Value, Direction>: View
where Value: AngularCoordinate,
      Value.DirectionType == Direction,
      Direction: CaseIterable & Hashable & RawRepresentable & Sendable,
      Direction.RawValue == String,
      Direction.AllCases: RandomAccessCollection {

    @Environment(\.theme) var theme
    @Environment(\.isEnabled) private var isEnabled

    @Binding var value: Value?
    @Binding var format: CoordinateFormat

    let topLabel: String?
    let topLabelSpacer: Bool
    let bottomLabelConfig: BottomLabelConfig
    let alertingState: InputAlertingState
    let config: CoordinateFieldConfig
    let onSegmentFilled: (@Sendable () -> Void)?

    // Axis-specific layout constants
    let degreesPlaceholder: String
    let degreesMaxChar: Int
    let signedDDMaxChar: Int
    let unsignedDDMaxChar: Int
    let positiveDirection: Direction

    @State private var direction: Direction
    @State private var degreesText: String = ""
    @State private var minutesText: String = ""
    @State private var secondsText: String = ""
    /// Shared by both `.signedDecimalDegrees` and `.decimalDegrees` formats.
    @State private var decimalDegreesText: String = ""

    init(
        value: Binding<Value?>,
        format: Binding<CoordinateFormat>,
        topLabel: String? = nil,
        topLabelSpacer: Bool = false,
        bottomLabelConfig: BottomLabelConfig = .init(isVisible: false),
        alertingState: InputAlertingState = .default,
        config: CoordinateFieldConfig = .standard,
        onSegmentFilled: (@Sendable () -> Void)? = nil,
        degreesPlaceholder: String,
        degreesMaxChar: Int,
        signedDDMaxChar: Int,
        unsignedDDMaxChar: Int,
        defaultDirection: Direction,
        positiveDirection: Direction
    ) {
        self._value = value
        self._format = format
        self.topLabel = topLabel
        self.topLabelSpacer = topLabelSpacer
        self.bottomLabelConfig = bottomLabelConfig
        self.alertingState = alertingState
        self.config = config
        self.onSegmentFilled = onSegmentFilled
        self.degreesPlaceholder = degreesPlaceholder
        self.degreesMaxChar = degreesMaxChar
        self.signedDDMaxChar = signedDDMaxChar
        self.unsignedDDMaxChar = unsignedDDMaxChar
        self.positiveDirection = positiveDirection
        self._direction = State(initialValue: defaultDirection)

        // Synchronously populate segments from the initial binding value so the first
        // render shows filled fields and avoids a nil→non-nil flash on the caller's side.
        guard let val = value.wrappedValue else { return }
        let fmt = format.wrappedValue
        let secsPrec = config.secondsPrecision
        switch fmt {
        case .signedDecimalDegrees:
            self._decimalDegreesText = State(initialValue: String(format: "%.5f", val.decimalDegrees))
        case .decimalDegrees:
            self._direction = State(initialValue: val.direction)
            self._decimalDegreesText = State(initialValue: String(format: "%.5f", val.unsignedDecimalDegrees))
        case .ddm:
            let ddm = val.degreesDecimalMinutes
            self._direction = State(initialValue: val.direction)
            self._degreesText = State(initialValue: String(ddm.degrees))
            self._minutesText = State(initialValue: String(format: "%.3f", ddm.minutes))
        case .dms:
            let dms = val.degreesMinutesSeconds
            self._direction = State(initialValue: val.direction)
            self._degreesText = State(initialValue: String(dms.degrees))
            self._minutesText = State(initialValue: String(dms.minutes))
            self._secondsText = State(initialValue: String(format: "%.\(secsPrec)f", dms.seconds))
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.grid0_5x) {
            buildTopLabel()
            buildSegments()
            BottomLabel(bottomLabelConfig)
        }
        .onChange(of: format) { _, _ in populateFromBinding() }
        .onChange(of: direction) { _, _ in validate() }
        .onChange(of: degreesText) { _, _ in validate() }
        .onChange(of: minutesText) { _, _ in validate() }
        .onChange(of: secondsText) { _, _ in validate() }
        .onChange(of: decimalDegreesText) { _, _ in validate() }
    }

    // MARK: - Top Label

    @ViewBuilder
    private func buildTopLabel() -> some View {
        if let top = topLabel {
            Text(top)
                .foregroundColor(theme.color.primary)
                .fontStyle(theme.typography.subhead)
        } else if topLabelSpacer {
            Text("-")
                .foregroundColor(theme.color.surfaceHigh.opacity(0))
                .fontStyle(theme.typography.subhead)
        }
    }

    // MARK: - Segments

    @ViewBuilder
    private func buildSegments() -> some View {
        switch format {
        case .signedDecimalDegrees: buildSignedDDSegment()
        case .decimalDegrees:       buildUnsignedDDSegments()
        case .ddm:                  buildDDMSegments()
        case .dms:                  buildDMSSegments()
        }
    }

    // ±DD: single signed decimal field — expands to fill available width
    private func buildSignedDDSegment() -> some View {
        HStack(spacing: theme.spacing.grid0_5x) {
            InputField(text: $decimalDegreesText, placeholder: "±0.00000",
                       filter: .custom("[^0-9.-]"), maxCharacterCount: signedDDMaxChar)
                .textFieldStyle(InputFieldStyle(signedDDState, config: segmentInputConfig))
            delimiterText("°")
        }
    }

    // DD: unsigned decimal degrees + hemisphere indicator (ISO 6709 — indicator follows digits)
    private func buildUnsignedDDSegments() -> some View {
        HStack(spacing: theme.spacing.grid0_5x) {
            CoordinateSegmentField($decimalDegreesText, placeholder: "0.00000", suffix: "°",
                                   filter: .doubleOnly, maxChar: unsignedDDMaxChar,
                                   state: unsignedDDState, config: segmentInputConfig)
            cardinalControl
        }
    }

    // DDM: degrees + decimal minutes + hemisphere indicator (ISO 6709)
    private func buildDDMSegments() -> some View {
        HStack(spacing: theme.spacing.grid0_5x) {
            CoordinateSegmentField($degreesText, placeholder: degreesPlaceholder, suffix: "°",
                                   filter: .integerOnly, maxChar: degreesMaxChar,
                                   state: degreesState, config: segmentInputConfig)
            CoordinateSegmentField($minutesText, placeholder: "00.000", suffix: "'",
                                   filter: .doubleOnly, maxChar: 7,
                                   state: minutesDecimalState, config: segmentInputConfig)
            cardinalControl
        }
    }

    // DMS: always single row — compact fixedSize fields fit even on iPhone (ISO 6709)
    private func buildDMSSegments() -> some View {
        HStack(spacing: theme.spacing.grid0_5x) {
            CoordinateSegmentField($degreesText, placeholder: degreesPlaceholder, suffix: "°",
                                   filter: .integerOnly, maxChar: degreesMaxChar,
                                   state: degreesState, config: segmentInputConfig)
            CoordinateSegmentField($minutesText, placeholder: "00", suffix: "'",
                                   filter: .integerOnly, maxChar: 2,
                                   state: minutesIntState, config: segmentInputConfig)
            CoordinateSegmentField($secondsText, placeholder: secondsPlaceholder, suffix: "\"",
                                   filter: .doubleOnly, maxChar: secondsMaxChar,
                                   state: secondsState, config: segmentInputConfig)
            cardinalControl
        }
    }

    // MARK: - Cardinal Control

    @ViewBuilder
    private var cardinalControl: some View {
        switch config.cardinalStyle {
        case .button:  CardinalButton(selection: $direction, highlightColor: config.cardinalColor)
        case .segment: CardinalSegmentControl(selection: $direction, highlightColor: config.cardinalColor)
        }
    }

    // MARK: - Delimiter (±DD only)

    private func delimiterText(_ symbol: String) -> some View {
        Text(symbol)
            .foregroundColor(theme.color.secondary)
            .fontStyle(theme.typography.body)
    }

    // MARK: - Seconds Precision

    private var secondsPlaceholder: String {
        config.secondsPrecision == 0 ? "00" : "00." + String(repeating: "0", count: config.secondsPrecision)
    }

    private var secondsMaxChar: Int {
        config.secondsPrecision == 0 ? 2 : 2 + 1 + config.secondsPrecision
    }

    // MARK: - Validation

    private func validate() {
        switch format {
        case .signedDecimalDegrees: validateSignedDD()
        case .decimalDegrees:       validateUnsignedDD()
        case .ddm:                  validateDDM()
        case .dms:                  validateDMS()
        }
    }

    private func validateSignedDD() {
        guard let val = Double(decimalDegreesText), Value.isValid(decimalDegrees: val) else {
            value = nil; return
        }
        value = Value(decimalDegrees: val)
    }

    private func validateUnsignedDD() {
        let maxDeg = Value.validRange.upperBound
        guard let val = Double(decimalDegreesText), val >= 0, val <= maxDeg else {
            value = nil; return
        }
        let signed = direction == positiveDirection ? val : -val
        guard Value.isValid(decimalDegrees: signed) else { value = nil; return }
        value = Value(decimalDegrees: signed)
    }

    private func validateDDM() {
        let maxDeg = Int(Value.validRange.upperBound)
        guard let degs = Int(degreesText),
              let mins = Double(minutesText),
              degs >= 0, degs <= maxDeg,
              mins >= 0, mins < 60 else { value = nil; return }
        let decDeg = Double(degs) + mins / 60.0
        let signed = direction == positiveDirection ? decDeg : -decDeg
        guard Value.isValid(decimalDegrees: signed) else { value = nil; return }
        value = Value(decimalDegrees: signed)
    }

    private func validateDMS() {
        let maxDeg = Int(Value.validRange.upperBound)
        guard let degs = Int(degreesText),
              let mins = Int(minutesText),
              let secs = Double(secondsText),
              degs >= 0, degs <= maxDeg,
              mins >= 0, mins < 60,
              secs >= 0, secs < 60 else { value = nil; return }
        let decDeg = Double(degs) + Double(mins) / 60.0 + secs / 3600.0
        let signed = direction == positiveDirection ? decDeg : -decDeg
        guard Value.isValid(decimalDegrees: signed) else { value = nil; return }
        value = Value(decimalDegrees: signed)
    }

    // MARK: - Populate from Binding

    private func populateFromBinding() {
        guard let val = value else { clearSegments(); return }
        switch format {
        case .signedDecimalDegrees:
            decimalDegreesText = String(format: "%.5f", val.decimalDegrees)
        case .decimalDegrees:
            direction = val.direction
            decimalDegreesText = String(format: "%.5f", val.unsignedDecimalDegrees)
        case .ddm:
            let ddm = val.degreesDecimalMinutes
            direction = val.direction
            degreesText = String(ddm.degrees)
            minutesText = String(format: "%.3f", ddm.minutes)
        case .dms:
            let dms = val.degreesMinutesSeconds
            direction = val.direction
            degreesText = String(dms.degrees)
            minutesText = String(dms.minutes)
            secondsText = String(format: "%.\(config.secondsPrecision)f", dms.seconds)
        }
    }

    private func clearSegments() {
        degreesText = ""
        minutesText = ""
        secondsText = ""
        decimalDegreesText = ""
    }

    // MARK: - Segment Alerting State

    private var segmentInputConfig: InputFieldConfig {
        InputFieldConfig(fontColor: config.fontColor, fontStyle: config.fontStyle,
                         backgroundColor: config.backgroundColor,
                         cornerRadius: config.cornerRadius, borderColor: config.borderColor)
    }

    private var signedDDState: InputAlertingState {
        segmentState(text: decimalDegreesText, parse: Double.init, range: Value.validRange)
    }

    private var unsignedDDState: InputAlertingState {
        segmentState(text: decimalDegreesText, parse: Double.init, range: 0...Value.validRange.upperBound)
    }

    private var degreesState: InputAlertingState {
        segmentState(text: degreesText, parse: Int.init, range: 0...Int(Value.validRange.upperBound))
    }

    private var minutesDecimalState: InputAlertingState {
        segmentState(text: minutesText, parse: Double.init, range: 0.0..<60.0)
    }

    private var minutesIntState: InputAlertingState {
        segmentState(text: minutesText, parse: Int.init, range: 0..<60)
    }

    private var secondsState: InputAlertingState {
        segmentState(text: secondsText, parse: Double.init, range: 0.0..<60.0)
    }

    private func segmentState<T: Comparable, R: RangeExpression>(
        text: String, parse: (String) -> T?, range: R
    ) -> InputAlertingState where R.Bound == T {
        guard !text.isEmpty, let val = parse(text) else { return alertingState }
        return range.contains(val) ? alertingState : .warning
    }
}
