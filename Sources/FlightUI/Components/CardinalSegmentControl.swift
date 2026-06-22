import SwiftUI

// MARK: - Cardinal Segment Control

/// An internal control that shows all compass directions simultaneously,
/// with the currently selected direction highlighted in the accent colour.
///
/// Used by `LatitudeField`, `LongitudeField`, and `CoordinateField`
/// when `CoordinateFieldConfig.cardinalStyle` is `.segment`.
///
/// - Important: Each `Button` uses `.buttonStyle(.plain)` to prevent SwiftUI's
///   `Form` / `List` from expanding tap targets to fill the entire row. Without
///   this modifier, multiple buttons in the same row share an enlarged hit region,
///   causing taps on one direction button to fire the wrong button's action.
///
struct CardinalSegmentControl<Direction>: View
where Direction: CaseIterable & Hashable & RawRepresentable & Sendable,
      Direction.RawValue == String,
      Direction.AllCases: RandomAccessCollection {

    @Environment(\.theme) var theme
    @Environment(\.isEnabled) var isEnabled

    @Binding var selection: Direction
    var highlightColor: Color?

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(Direction.allCases), id: \.self) { option in
                Button { selection = option } label: {
                    Text(option.rawValue)
                        .fontStyle(theme.typography.bodyBold.withColor(labelColor(for: option)))
                        .frame(minWidth: 38, minHeight: theme.size.large)
                        .background(pillColor(for: option))
                        .cornerRadius(theme.radius.small)
                        .padding(3)
                }
                .buttonStyle(.plain)
                .disabled(!isEnabled)
            }
        }
        .background(theme.color.surfaceLow)
        .cornerRadius(theme.radius.medium)
    }

    private func labelColor(for option: Direction) -> Color {
        let isSelected = option == selection
        let base: Color = isSelected ? .black : theme.color.secondary
        return base.opacity(isEnabled ? 1 : FieldDefaults.disabledOpacity)
    }

    private func pillColor(for option: Direction) -> Color {
        let isSelected = option == selection
        return (isSelected ? (highlightColor ?? theme.color.inputOutput) : Color.clear)
            .opacity(isEnabled ? 1 : FieldDefaults.disabledOpacity)
    }
}
