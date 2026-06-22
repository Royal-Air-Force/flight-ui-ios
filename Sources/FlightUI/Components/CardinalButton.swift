import SwiftUI

// MARK: - Cardinal Button

/// A compact, fixed-size square button for selecting a compass direction (e.g. N/S or E/W).
///
/// Tapping cycles through all available cases in declaration order.
/// Used internally by `LatitudeField`, `LongitudeField`, and `CoordinateField`
/// as a compact alternative to a dropdown picker.
///
/// - Important: Uses `.buttonStyle(.plain)` to prevent SwiftUI's `Form` / `List`
///   from expanding the tap target to fill the entire row. Without this modifier,
///   multiple buttons in the same row share an enlarged hit region, causing taps
///   on one cardinal button to fire a different button's action.
///
struct CardinalButton<Direction>: View
where Direction: CaseIterable & Hashable & RawRepresentable & Sendable,
      Direction.RawValue == String,
      Direction.AllCases: RandomAccessCollection {

    @Environment(\.theme) var theme
    @Environment(\.isEnabled) var isEnabled

    @Binding var selection: Direction
    var highlightColor: Color?

    var body: some View {
        Button {
            let cases = Array(Direction.allCases)
            let idx = cases.firstIndex(of: selection) ?? 0
            selection = cases[(idx + 1) % cases.count]
        } label: {
            Text(selection.rawValue)
                .fontStyle(theme.typography.bodyBold.withColor(labelColor))
                .frame(width: theme.size.large, height: theme.size.large)
                .background(backgroundColor)
                .cornerRadius(theme.radius.medium)
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
    }

    private var labelColor: Color {
        Color.black.opacity(isEnabled ? 1 : FieldDefaults.disabledOpacity)
    }

    private var backgroundColor: Color {
        (highlightColor ?? theme.color.inputOutput).opacity(isEnabled ? 1 : FieldDefaults.disabledOpacity)
    }
}
