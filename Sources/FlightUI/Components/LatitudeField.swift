import SwiftUI
import AviationMaths

// MARK: - Latitude Field

/// A segmented input field for entering a geographic latitude.
///
/// Supports four entry formats controlled by the `format` binding:
/// - `.signedDecimalDegrees`: Single signed decimal field (positive = N, negative = S)
/// - `.decimalDegrees`: Hemisphere toggle + unsigned decimal degrees (e.g. N 51.47520°)
/// - `.ddm`: Hemisphere toggle + degrees + decimal minutes (e.g. N 51° 28.741')
/// - `.dms`: Hemisphere toggle + degrees + minutes + decimal seconds
///
/// The `latitude` binding receives a valid `Latitude` once all segments are filled
/// and in-range, or `nil` while typing or when any segment is out of range.
///
/// Example:
/// ```swift
/// @State var latitude: Latitude? = nil
/// @State var format: CoordinateFormat = .ddm
///
/// LatitudeField(latitude: $latitude, format: $format, topLabel: "Latitude")
/// ```
///
public struct LatitudeField: View {
    @Binding var latitude: Latitude?
    @Binding var format: CoordinateFormat

    let topLabel: String?
    let topLabelSpacer: Bool
    let bottomLabelConfig: BottomLabelConfig
    let alertingState: InputAlertingState
    let config: CoordinateFieldConfig
    /// Called when a segment reaches its maximum character count.
    /// No-op by default — implement to drive custom `@FocusState` advancement.
    let onSegmentFilled: (@Sendable () -> Void)?

    public init(
        latitude: Binding<Latitude?>,
        format: Binding<CoordinateFormat>,
        topLabel: String? = nil,
        topLabelSpacer: Bool = false,
        bottomLabelConfig: BottomLabelConfig = .init(isVisible: false),
        alertingState: InputAlertingState = .default,
        config: CoordinateFieldConfig = .standard,
        onSegmentFilled: (@Sendable () -> Void)? = nil
    ) {
        self._latitude = latitude
        self._format = format
        self.topLabel = topLabel
        self.topLabelSpacer = topLabelSpacer
        self.bottomLabelConfig = bottomLabelConfig
        self.alertingState = alertingState
        self.config = config
        self.onSegmentFilled = onSegmentFilled
    }

    public var body: some View {
        AxisCoordinateField(
            value: $latitude,
            format: $format,
            topLabel: topLabel,
            topLabelSpacer: topLabelSpacer,
            bottomLabelConfig: bottomLabelConfig,
            alertingState: alertingState,
            config: config,
            onSegmentFilled: onSegmentFilled,
            degreesPlaceholder: "00",
            degreesMaxChar: 2,
            signedDDMaxChar: 9,
            unsignedDDMaxChar: 8,
            defaultDirection: .north,
            positiveDirection: .north
        )
    }
}
