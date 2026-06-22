import SwiftUI

// MARK: - CoordinateField Aligned Card Layout

/// Preference key used to propagate the longitude degrees field width up to the CoordinateField,
/// so the latitude degrees field can be set to the same width for column alignment.
private struct CardDegreesWidthKey: PreferenceKey {
    nonisolated(unsafe) static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

extension CoordinateField {

    // MARK: - Aligned DDM Card (iPhone stacked layout)

    /// Stacked lat/lon DDM card with the degrees columns equalised.
    func buildAlignedDDMCard() -> some View {
        buildAlignedCard {
            CoordinateSegmentField($latMinutesText, placeholder: "00.000", suffix: "'",
                                   filter: .doubleOnly, maxChar: 7,
                                   state: latMinDecState, config: segmentInputConfig)
        } lonExtra: {
            CoordinateSegmentField($lonMinutesText, placeholder: "00.000", suffix: "'",
                                   filter: .doubleOnly, maxChar: 7,
                                   state: lonMinDecState, config: segmentInputConfig)
        }
    }

    // MARK: - Aligned DMS Card (iPhone stacked layout)

    /// Stacked lat/lon DMS card with the degrees columns equalised.
    func buildAlignedDMSCard() -> some View {
        buildAlignedCard {
            CoordinateSegmentField($latMinutesText, placeholder: "00", suffix: "'",
                                   filter: .integerOnly, maxChar: 2,
                                   state: latMinIntState, config: segmentInputConfig)
            CoordinateSegmentField($latSecondsText, placeholder: latSecondsPlaceholder, suffix: "\"",
                                   filter: .doubleOnly, maxChar: latSecondsMaxChar,
                                   state: latSecondsState, config: segmentInputConfig)
        } lonExtra: {
            CoordinateSegmentField($lonMinutesText, placeholder: "00", suffix: "'",
                                   filter: .integerOnly, maxChar: 2,
                                   state: lonMinIntState, config: segmentInputConfig)
            CoordinateSegmentField($lonSecondsText, placeholder: lonSecondsPlaceholder, suffix: "\"",
                                   filter: .doubleOnly, maxChar: lonSecondsMaxChar,
                                   state: lonSecondsState, config: segmentInputConfig)
        }
    }

    // MARK: - Shared Card Builder

    /// Builds a stacked lat/lon card with equalised degrees columns.
    /// The longitude degrees field (3 digits) is measured and its width applied to the latitude
    /// degrees field (2 digits) so all columns align.
    /// `latExtra` and `lonExtra` supply the additional segments (minutes, seconds) for each row.
    private func buildAlignedCard<LatExtra: View, LonExtra: View>(
        @ViewBuilder latExtra: () -> LatExtra,
        @ViewBuilder lonExtra: () -> LonExtra
    ) -> some View {
        let latDegreesMinWidth: CGFloat? = cardDegreesWidth > 0 ? cardDegreesWidth : nil
        return VStack(spacing: 0) {
            HStack(spacing: theme.spacing.grid0_5x) {
                axisLabel("Lat")
                CoordinateSegmentField($latDegreesText, placeholder: "00", suffix: "°",
                                       filter: .integerOnly, maxChar: 2,
                                       state: latDegreesState, config: segmentInputConfig,
                                       minWidth: latDegreesMinWidth)
                latExtra()
                cardinalLat()
                Spacer(minLength: 0)
            }
            .padding(theme.spacing.grid2x)
            cardSeparator()
            HStack(spacing: theme.spacing.grid0_5x) {
                axisLabel("Lon")
                CoordinateSegmentField($lonDegreesText, placeholder: "000", suffix: "°",
                                       filter: .integerOnly, maxChar: 3,
                                       state: lonDegreesState, config: segmentInputConfig)
                    .background(GeometryReader { geo in
                        Color.clear.preference(key: CardDegreesWidthKey.self, value: geo.size.width)
                    })
                lonExtra()
                cardinalLon()
                Spacer(minLength: 0)
            }
            .padding(theme.spacing.grid2x)
        }
        .onPreferenceChange(CardDegreesWidthKey.self) { cardDegreesWidth = $0 }
    }
}
