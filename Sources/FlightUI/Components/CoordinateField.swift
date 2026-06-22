import SwiftUI
import AviationMaths

// MARK: - Coordinate Field

/// A composite input field for entering a full geographic position (latitude + longitude).
///
/// Renders both axes inside a unified card, with a built-in format picker (±DD / DD / DDM / DMS)
/// and a live cross-format preview that updates as the user types. On iPad (`.regular` width),
/// the ±DD and DD formats place both axes on a single row.
///
/// The `format` binding is still useful for persistence and offset display — the built-in picker
/// handles switching, so apps should not add a second external picker.
///
/// When embedded in a SwiftUI `Form`, the component automatically clears the list row background
/// so only the card background is visible. No `.listRowInsets` override is needed.
///
/// Example:
/// ```swift
/// @State var position: Position2D? = nil
/// @State var format: CoordinateFormat = .ddm
///
/// CoordinateField(position: $position, format: $format, topLabel: "Position")
/// ```
///
public struct CoordinateField: View {
    @Environment(\.theme) var theme

    @Binding var position: Position2D?
    @Binding var format: CoordinateFormat

    let topLabel: String?
    let topLabelSpacer: Bool
    let bottomLabelConfig: BottomLabelConfig
    let alertingState: InputAlertingState
    let config: CoordinateFieldConfig

    // Segment text state — latitude
    @State var latDecimalDegreesText: String = ""
    @State var latDegreesText: String = ""
    @State var latMinutesText: String = ""
    @State var latSecondsText: String = ""
    @State var latDirection: LatitudeDirection = .north

    // Segment text state — longitude
    @State var lonDecimalDegreesText: String = ""
    @State var lonDegreesText: String = ""
    @State var lonMinutesText: String = ""
    @State var lonSecondsText: String = ""
    @State var lonDirection: LongitudeDirection = .west

    // Column-alignment state (iPhone stacked DDM/DMS card)
    @State var cardDegreesWidth: CGFloat = 0

    public init(
        position: Binding<Position2D?>,
        format: Binding<CoordinateFormat>,
        topLabel: String? = nil,
        topLabelSpacer: Bool = false,
        bottomLabelConfig: BottomLabelConfig = .init(isVisible: false),
        alertingState: InputAlertingState = .default,
        config: CoordinateFieldConfig = .standard
    ) {
        self._position = position
        self._format = format
        self.topLabel = topLabel
        self.topLabelSpacer = topLabelSpacer
        self.bottomLabelConfig = bottomLabelConfig
        self.alertingState = alertingState
        self.config = config

        // Synchronously populate segments from the initial binding value so the first
        // render shows filled fields and avoids a nil→non-nil flash on the caller's side.
        // Direction is only set when magnitude > 0 — at exactly 0° the direction is
        // ambiguous in IEEE 754 (-0.0 == 0.0), so we preserve the @State default.
        guard let pos = position.wrappedValue else { return }
        let fmt = format.wrappedValue
        let secsPrec = config.secondsPrecision
        let setLatDir = pos.latitude.unsignedDecimalDegrees > 0
        let setLonDir = pos.longitude.unsignedDecimalDegrees > 0
        switch fmt {
        case .signedDecimalDegrees:
            self._latDecimalDegreesText = State(initialValue: String(format: "%.5f", pos.latitude.decimalDegrees))
            self._lonDecimalDegreesText = State(initialValue: String(format: "%.5f", pos.longitude.decimalDegrees))
        case .decimalDegrees:
            if setLatDir { self._latDirection = State(initialValue: pos.latitude.direction) }
            self._latDecimalDegreesText = State(initialValue: String(format: "%.5f", pos.latitude.unsignedDecimalDegrees))
            if setLonDir { self._lonDirection = State(initialValue: pos.longitude.direction) }
            self._lonDecimalDegreesText = State(initialValue: String(format: "%.5f", pos.longitude.unsignedDecimalDegrees))
        case .ddm:
            let latDDM = pos.latitude.degreesDecimalMinutes
            let lonDDM = pos.longitude.degreesDecimalMinutes
            if setLatDir { self._latDirection = State(initialValue: pos.latitude.direction) }
            self._latDegreesText = State(initialValue: String(latDDM.degrees))
            self._latMinutesText = State(initialValue: String(format: "%.3f", latDDM.minutes))
            if setLonDir { self._lonDirection = State(initialValue: pos.longitude.direction) }
            self._lonDegreesText = State(initialValue: String(lonDDM.degrees))
            self._lonMinutesText = State(initialValue: String(format: "%.3f", lonDDM.minutes))
        case .dms:
            let latDMS = pos.latitude.degreesMinutesSeconds
            let lonDMS = pos.longitude.degreesMinutesSeconds
            if setLatDir { self._latDirection = State(initialValue: pos.latitude.direction) }
            self._latDegreesText = State(initialValue: String(latDMS.degrees))
            self._latMinutesText = State(initialValue: String(latDMS.minutes))
            self._latSecondsText = State(initialValue: String(format: "%.\(secsPrec)f", latDMS.seconds))
            if setLonDir { self._lonDirection = State(initialValue: pos.longitude.direction) }
            self._lonDegreesText = State(initialValue: String(lonDMS.degrees))
            self._lonMinutesText = State(initialValue: String(lonDMS.minutes))
            self._lonSecondsText = State(initialValue: String(format: "%.\(secsPrec)f", lonDMS.seconds))
        }
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.grid1x) {
            buildTopLabel()
            buildHeader()
            buildCard()
            buildPreview()
            BottomLabel(bottomLabelConfig)
        }
        .listRowBackground(Color.clear)
        .onChange(of: format) { _, _ in populateSegments() }
        .onChange(of: latDecimalDegreesText) { _, _ in assembleFromCurrentState() }
        .onChange(of: latDegreesText) { _, _ in assembleFromCurrentState() }
        .onChange(of: latMinutesText) { _, _ in assembleFromCurrentState() }
        .onChange(of: latSecondsText) { _, _ in assembleFromCurrentState() }
        .onChange(of: latDirection) { _, _ in assembleFromCurrentState() }
        .onChange(of: lonDecimalDegreesText) { _, _ in assembleFromCurrentState() }
        .onChange(of: lonDegreesText) { _, _ in assembleFromCurrentState() }
        .onChange(of: lonMinutesText) { _, _ in assembleFromCurrentState() }
        .onChange(of: lonSecondsText) { _, _ in assembleFromCurrentState() }
        .onChange(of: lonDirection) { _, _ in assembleFromCurrentState() }
    }
}

// MARK: - Layout

extension CoordinateField {

    @ViewBuilder
    func buildTopLabel() -> some View {
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

    func buildHeader() -> some View {
        Picker("Format", selection: $format) {
            Text("±DD").tag(CoordinateFormat.signedDecimalDegrees)
            Text("DD").tag(CoordinateFormat.decimalDegrees)
            Text("DDM").tag(CoordinateFormat.ddm)
            Text("DMS").tag(CoordinateFormat.dms)
        }
        .pickerStyle(.segmented)
    }

    func buildCard() -> some View {
        VStack(spacing: 0) {
            switch format {
            case .signedDecimalDegrees, .decimalDegrees:
                ViewThatFits(in: .horizontal) {
                    buildCombinedDDRow()
                    VStack(spacing: 0) {
                        buildLatRow()
                        cardSeparator()
                        buildLonRow()
                    }
                }
            case .ddm:
                ViewThatFits(in: .horizontal) {
                    buildCombinedDDMRow()
                    buildAlignedDDMCard()
                }
            case .dms:
                ViewThatFits(in: .horizontal) {
                    buildCombinedDMSRow()
                    buildAlignedDMSCard()
                }
            }
        }
        .background(theme.color.surfaceHigh)
        .cornerRadius(theme.radius.medium)
    }

    func cardSeparator() -> some View {
        theme.color.secondary.opacity(0.2).frame(height: 1)
    }

    func buildCombinedDDRow() -> some View {
        HStack(spacing: theme.spacing.grid2x) {
            HStack(spacing: theme.spacing.grid0_5x) {
                axisLabel("Lat")
                buildLatSegmentsDD()
            }
            HStack(spacing: theme.spacing.grid0_5x) {
                axisLabel("Lon")
                buildLonSegmentsDD()
            }
            Spacer(minLength: 0)
        }
        .padding(theme.spacing.grid2x)
    }

    func buildCombinedDDMRow() -> some View {
        HStack(spacing: theme.spacing.grid2x) {
            HStack(spacing: theme.spacing.grid0_5x) {
                axisLabel("Lat")
                buildLatSegmentsDDM()
            }
            HStack(spacing: theme.spacing.grid0_5x) {
                axisLabel("Lon")
                buildLonSegmentsDDM()
            }
            Spacer(minLength: 0)
        }
        .padding(theme.spacing.grid2x)
    }

    func buildCombinedDMSRow() -> some View {
        HStack(spacing: theme.spacing.grid2x) {
            HStack(spacing: theme.spacing.grid0_5x) {
                axisLabel("Lat")
                buildLatSegmentsDMS()
            }
            HStack(spacing: theme.spacing.grid0_5x) {
                axisLabel("Lon")
                buildLonSegmentsDMS()
            }
            Spacer(minLength: 0)
        }
        .padding(theme.spacing.grid2x)
    }

    func buildLatRow() -> some View {
        HStack(spacing: theme.spacing.grid0_5x) {
            axisLabel("Lat")
            buildLatSegments()
            Spacer(minLength: 0)
        }
        .padding(theme.spacing.grid2x)
    }

    func buildLonRow() -> some View {
        HStack(spacing: theme.spacing.grid0_5x) {
            axisLabel("Lon")
            buildLonSegments()
            Spacer(minLength: 0)
        }
        .padding(theme.spacing.grid2x)
    }

    func axisLabel(_ text: String) -> some View {
        Text(text)
            .foregroundColor(theme.color.primary)
            .fontStyle(theme.typography.bodyBold)
            .frame(minWidth: 28, alignment: .leading)
    }

    @ViewBuilder
    func buildLatSegments() -> some View {
        switch format {
        case .signedDecimalDegrees, .decimalDegrees: buildLatSegmentsDD()
        case .ddm:                                   buildLatSegmentsDDM()
        case .dms:                                   buildLatSegmentsDMS()
        }
    }

    @ViewBuilder
    func buildLatSegmentsDD() -> some View {
        if format == .decimalDegrees {
            CoordinateSegmentField($latDecimalDegreesText, placeholder: "0.00000", suffix: "°",
                                   filter: .doubleOnly, maxChar: 8,
                                   state: latDDState, config: segmentInputConfig)
            cardinalLat()
        } else {
            InputField(text: $latDecimalDegreesText, placeholder: "±0.00000",
                       filter: .custom("[^0-9.-]"), maxCharacterCount: 9)
                .textFieldStyle(InputFieldStyle(latDDState, config: segmentInputConfig))
            delimiterText("°")
        }
    }

    func buildLatSegmentsDDM() -> some View {
        HStack(spacing: theme.spacing.grid0_5x) {
            CoordinateSegmentField($latDegreesText, placeholder: "00", suffix: "°",
                                   filter: .integerOnly, maxChar: 2,
                                   state: latDegreesState, config: segmentInputConfig)
            CoordinateSegmentField($latMinutesText, placeholder: "00.000", suffix: "'",
                                   filter: .doubleOnly, maxChar: 7,
                                   state: latMinDecState, config: segmentInputConfig)
            cardinalLat()
        }
    }

    func buildLatSegmentsDMS() -> some View {
        HStack(spacing: theme.spacing.grid0_5x) {
            CoordinateSegmentField($latDegreesText, placeholder: "00", suffix: "°",
                                   filter: .integerOnly, maxChar: 2,
                                   state: latDegreesState, config: segmentInputConfig)
            CoordinateSegmentField($latMinutesText, placeholder: "00", suffix: "'",
                                   filter: .integerOnly, maxChar: 2,
                                   state: latMinIntState, config: segmentInputConfig)
            CoordinateSegmentField($latSecondsText, placeholder: latSecondsPlaceholder, suffix: "\"",
                                   filter: .doubleOnly, maxChar: latSecondsMaxChar,
                                   state: latSecondsState, config: segmentInputConfig)
            cardinalLat()
        }
    }

    @ViewBuilder
    func buildLonSegments() -> some View {
        switch format {
        case .signedDecimalDegrees, .decimalDegrees: buildLonSegmentsDD()
        case .ddm:                                   buildLonSegmentsDDM()
        case .dms:                                   buildLonSegmentsDMS()
        }
    }

    @ViewBuilder
    func buildLonSegmentsDD() -> some View {
        if format == .decimalDegrees {
            CoordinateSegmentField($lonDecimalDegreesText, placeholder: "0.00000", suffix: "°",
                                   filter: .doubleOnly, maxChar: 9,
                                   state: lonDDState, config: segmentInputConfig)
            cardinalLon()
        } else {
            InputField(text: $lonDecimalDegreesText, placeholder: "±0.00000",
                       filter: .custom("[^0-9.-]"), maxCharacterCount: 10)
                .textFieldStyle(InputFieldStyle(lonDDState, config: segmentInputConfig))
            delimiterText("°")
        }
    }

    func buildLonSegmentsDDM() -> some View {
        HStack(spacing: theme.spacing.grid0_5x) {
            CoordinateSegmentField($lonDegreesText, placeholder: "000", suffix: "°",
                                   filter: .integerOnly, maxChar: 3,
                                   state: lonDegreesState, config: segmentInputConfig)
            CoordinateSegmentField($lonMinutesText, placeholder: "00.000", suffix: "'",
                                   filter: .doubleOnly, maxChar: 7,
                                   state: lonMinDecState, config: segmentInputConfig)
            cardinalLon()
        }
    }

    func buildLonSegmentsDMS() -> some View {
        HStack(spacing: theme.spacing.grid0_5x) {
            CoordinateSegmentField($lonDegreesText, placeholder: "000", suffix: "°",
                                   filter: .integerOnly, maxChar: 3,
                                   state: lonDegreesState, config: segmentInputConfig)
            CoordinateSegmentField($lonMinutesText, placeholder: "00", suffix: "'",
                                   filter: .integerOnly, maxChar: 2,
                                   state: lonMinIntState, config: segmentInputConfig)
            CoordinateSegmentField($lonSecondsText, placeholder: lonSecondsPlaceholder, suffix: "\"",
                                   filter: .doubleOnly, maxChar: lonSecondsMaxChar,
                                   state: lonSecondsState, config: segmentInputConfig)
            cardinalLon()
        }
    }

    // MARK: - Cardinal Controls

    @ViewBuilder
    func cardinalLat() -> some View {
        switch config.cardinalStyle {
        case .button:  CardinalButton(selection: $latDirection, highlightColor: config.cardinalColor)
        case .segment: CardinalSegmentControl(selection: $latDirection, highlightColor: config.cardinalColor)
        }
    }

    @ViewBuilder
    func cardinalLon() -> some View {
        switch config.cardinalStyle {
        case .button:  CardinalButton(selection: $lonDirection, highlightColor: config.cardinalColor)
        case .segment: CardinalSegmentControl(selection: $lonDirection, highlightColor: config.cardinalColor)
        }
    }

    // MARK: - Helpers

    func delimiterText(_ symbol: String) -> some View {
        Text(symbol).foregroundColor(theme.color.secondary).fontStyle(theme.typography.body)
    }

    var latSecondsPlaceholder: String {
        config.secondsPrecision == 0 ? "00" : "00." + String(repeating: "0", count: config.secondsPrecision)
    }

    var latSecondsMaxChar: Int {
        config.secondsPrecision == 0 ? 2 : 2 + 1 + config.secondsPrecision
    }

    var lonSecondsPlaceholder: String { latSecondsPlaceholder }
    var lonSecondsMaxChar: Int { latSecondsMaxChar }

    // MARK: - Preview

    @ViewBuilder
    func buildPreview() -> some View {
        if let pos = position {
            VStack(alignment: .leading, spacing: theme.spacing.grid1x) {
                previewRow("±DD", signedDDString(pos))
                previewRow("DD", decimalDDString(pos))
                previewRow("DDM", ddmString(pos))
                previewRow("DMS", dmsString(pos))
            }
            .padding(theme.spacing.grid2x)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(theme.color.surfaceHigh.opacity(0.6))
            .cornerRadius(theme.radius.medium)
        }
    }

    func previewRow(_ label: String, _ value: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: theme.spacing.grid1x) {
            Text(label)
                .foregroundColor(theme.color.secondary)
                .fontStyle(theme.typography.caption1)
                .frame(minWidth: 36, alignment: .leading)
            Text(value)
                .foregroundColor(theme.color.inputOutput)
                .fontStyle(theme.typography.caption1)
        }
    }
}
