import SwiftUI
import AviationMaths

// MARK: - Longitude Field

/// A segmented input field for entering a geographic longitude.
///
/// Supports four entry formats controlled by the `format` binding:
/// - `.signedDecimalDegrees`: Single signed decimal field (positive = E, negative = W)
/// - `.decimalDegrees`: Hemisphere toggle + unsigned decimal degrees (e.g. E 001.47520°)
/// - `.ddm`: Hemisphere toggle + degrees + decimal minutes (e.g. E 001° 52.624')
/// - `.dms`: Hemisphere toggle + degrees + minutes + decimal seconds
///
/// The `longitude` binding receives a valid `Longitude` once all segments are filled
/// and in-range, or `nil` while typing or when any segment is out of range.
///
/// Example:
/// ```swift
/// @State var longitude: Longitude? = nil
/// @State var format: CoordinateFormat = .ddm
///
/// LongitudeField(longitude: $longitude, format: $format, topLabel: "Longitude")
/// ```
///
public struct LongitudeField: View {
    @Binding var longitude: Longitude?
    @Binding var format: CoordinateFormat

    let topLabel: String?
    let topLabelSpacer: Bool
    let bottomLabelConfig: BottomLabelConfig
    let alertingState: InputAlertingState
    let config: CoordinateFieldConfig

    public init(
        longitude: Binding<Longitude?>,
        format: Binding<CoordinateFormat>,
        topLabel: String? = nil,
        topLabelSpacer: Bool = false,
        bottomLabelConfig: BottomLabelConfig = .init(isVisible: false),
        alertingState: InputAlertingState = .default,
        config: CoordinateFieldConfig = .standard
    ) {
        self._longitude = longitude
        self._format = format
        self.topLabel = topLabel
        self.topLabelSpacer = topLabelSpacer
        self.bottomLabelConfig = bottomLabelConfig
        self.alertingState = alertingState
        self.config = config
    }

    public var body: some View {
        AxisCoordinateField(
            value: $longitude,
            format: $format,
            topLabel: topLabel,
            topLabelSpacer: topLabelSpacer,
            bottomLabelConfig: bottomLabelConfig,
            alertingState: alertingState,
            config: config,
            degreesPlaceholder: "000",
            degreesMaxChar: 3,
            signedDDMaxChar: 10,
            unsignedDDMaxChar: 9,
            defaultDirection: .east,
            positiveDirection: .east
        )
    }
}
