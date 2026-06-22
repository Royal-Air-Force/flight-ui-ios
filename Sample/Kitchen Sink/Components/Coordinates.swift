import SwiftUI
import FlightUI
import AviationMaths

// MARK: - Coordinates

struct Coordinates: View {
    @Environment(\.theme) var theme

    @State private var format: CoordinateFormat = .ddm

    @State private var latitude: Latitude?
    @State private var longitude: Longitude?
    @State private var position: Position2D?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.grid4x) {
                compositeField
                individualFields
                cardinalStyles
                precisionDemo
                alertingStates
            }
            .padding(.horizontal, theme.spacing.grid3x)
        }
        .background(theme.color.background)
        .navigationBarTitle("Coordinates")
    }

    // MARK: - Composite CoordinateField

    var compositeField: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "CoordinateField",
                subTitle: "Card layout with built-in format picker and cross-format preview. "
                        + "Binds to Position2D? — nil until both axes are valid. "
                        + "On iPad, ±DD and DD formats show both axes on a single row."
            )
            CoordinateField(
                position: $position,
                format: $format,
                topLabel: "Position",
                bottomLabelConfig: positionBottomLabel
            )
            .padding(.top, theme.spacing.grid1x)
        }
    }

    private var positionBottomLabel: BottomLabelConfig {
        position != nil
            ? BottomLabelConfig("Valid position", state: .nominal)
            : BottomLabelConfig("Enter lat and lon to complete", state: .default)
    }

    // MARK: - Individual LatitudeField / LongitudeField

    var individualFields: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "LatitudeField / LongitudeField",
                subTitle: "Standalone single-axis fields. Cardinal direction toggles on tap. "
                        + "Fields are compact (fixedSize) — DMS always fits on a single row."
            )

            Picker("Format", selection: $format) {
                Text("±DD").tag(CoordinateFormat.signedDecimalDegrees)
                Text("DD").tag(CoordinateFormat.decimalDegrees)
                Text("DDM").tag(CoordinateFormat.ddm)
                Text("DMS").tag(CoordinateFormat.dms)
            }
            .pickerStyle(.segmented)
            .padding(.top, theme.spacing.grid1x)

            LatitudeField(
                latitude: $latitude,
                format: $format,
                topLabel: "Latitude",
                bottomLabelConfig: latBottomLabel
            )
            .padding(.top, theme.spacing.grid1x)

            LongitudeField(
                longitude: $longitude,
                format: $format,
                topLabel: "Longitude",
                bottomLabelConfig: lonBottomLabel
            )
            .padding(.top, theme.spacing.grid1x)
        }
    }

    private var latBottomLabel: BottomLabelConfig {
        latitude != nil
            ? BottomLabelConfig(latitude?.description, state: .nominal)
            : BottomLabelConfig("Incomplete or out of range", state: .default)
    }

    private var lonBottomLabel: BottomLabelConfig {
        longitude != nil
            ? BottomLabelConfig(longitude?.description, state: .nominal)
            : BottomLabelConfig("Incomplete or out of range", state: .default)
    }

    // MARK: - Cardinal Input Styles

    var cardinalStyles: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "Cardinal Input Styles",
                subTitle: "The cardinalStyle parameter controls the hemisphere selector. "
                        + ".segment (default) shows both options simultaneously as a toggle. "
                        + ".button shows a compact cycling button."
            )

            Text(".button")
                .foregroundColor(theme.color.secondary)
                .fontStyle(theme.typography.caption1)
                .padding(.top, theme.spacing.grid1x)
            LatitudeField(
                latitude: .constant(Latitude(decimalDegrees: 51.4752)),
                format: .constant(.ddm),
                config: CoordinateFieldConfig(cardinalStyle: .button)
            )

            Text(".segment (default)")
                .foregroundColor(theme.color.secondary)
                .fontStyle(theme.typography.caption1)
                .padding(.top, theme.spacing.grid1x)
            LatitudeField(
                latitude: .constant(Latitude(decimalDegrees: 51.4752)),
                format: .constant(.ddm),
                config: CoordinateFieldConfig(cardinalStyle: .segment)
            )

            Text(".segment — DMS")
                .foregroundColor(theme.color.secondary)
                .fontStyle(theme.typography.caption1)
                .padding(.top, theme.spacing.grid1x)
            LongitudeField(
                longitude: .constant(Longitude(decimalDegrees: -1.4752)),
                format: .constant(.dms),
                config: CoordinateFieldConfig(cardinalStyle: .segment)
            )
        }
    }

    // MARK: - Seconds Precision

    var precisionDemo: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "Seconds Precision",
                subTitle: "The secondsPrecision parameter controls decimal places for seconds in DMS. "
                        + "Default is 1. Set to 0 for whole seconds, or higher for survey-grade entry."
            )

            precisionRow(label: "precision: 0", precision: 0)
            precisionRow(label: "precision: 1 (default)", precision: 1)
            precisionRow(label: "precision: 3", precision: 3)
        }
    }

    @ViewBuilder
    private func precisionRow(label: String, precision: Int) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.grid0_5x) {
            Text(label)
                .foregroundColor(theme.color.secondary)
                .fontStyle(theme.typography.caption1)
                .padding(.top, theme.spacing.grid1x)
            LatitudeField(
                latitude: .constant(Latitude(decimalDegrees: 51.4752)),
                format: .constant(.dms),
                config: CoordinateFieldConfig(secondsPrecision: precision)
            )
        }
    }

    // MARK: - Alerting States

    var alertingStates: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "Alerting States",
                subTitle: "Fields accept an alertingState parameter for situational awareness. "
                        + "Individual segments show .warning when their value is out of range."
            )

            alertingRow(label: "Default (editing)", state: .default)
            alertingRow(label: "Advisory (read-only output)", state: .advisory)
            alertingRow(label: "Nominal (confirmed)", state: .nominal)
            alertingRow(label: "Caution (review required)", state: .caution)
            alertingRow(label: "Warning (error)", state: .warning)
        }
    }

    @ViewBuilder
    private func alertingRow(label: String, state: InputAlertingState) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.grid0_5x) {
            Text(label)
                .foregroundColor(theme.color.secondary)
                .fontStyle(theme.typography.caption1)
                .padding(.top, theme.spacing.grid1x)
            LatitudeField(
                latitude: .constant(Latitude(decimalDegrees: 51.4752)),
                format: .constant(.ddm),
                alertingState: state
            )
            .disabled(state == .advisory)
        }
    }
}
