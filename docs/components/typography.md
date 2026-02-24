# 🔠 Typography

FlightUI uses a fixed-scale type system defined in `ThemeTypographyData`. Every scale is a `FontStyle` — an immutable, `Sendable` struct that carries size, weight, design, line spacing, character spacing, and an optional colour override. Apply any style to a view with the `.fontStyle()` modifier.

## Type Scale

| Token | Size | Weight | Line Spacing | Use for |
|-------|------|--------|--------------|---------|
| `largeTitle` | 34pt | Bold | +7 | Screen titles, major headings |
| `title1` | 30pt | Semibold | +3 | Section titles |
| `title2` | 28pt | Regular | +3 | Panel headers, card titles |
| `title3` | 24pt | Regular | +2 | Sub-section headers |
| `headline` | 20pt | Semibold | +2 | Table column headers, emphasis labels |
| `subhead` | 18pt | Regular | +2 | Supporting headers, secondary section titles |
| `body` | 16pt | Regular | +2 | Standard body text, field labels |
| `bodyBold` | 16pt | Semibold | +2 | Emphasis within body text, button labels |
| `callout` | 15pt | Semibold | +2 | Character spacing: +2. Annotations, callouts with tracking |
| `footnote` | 15pt | Semibold | +2 | Supporting annotations |
| `caption1` | 15pt | Regular | +2 | Field labels, top/bottom input labels |
| `caption2` | 14pt | Regular | +1 | Smallest readable text; metadata only |

## Usage

```swift
struct MyView: View {
    @Environment(\.theme) var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.grid1x) {
            Text("Navigation Fix")
                .fontStyle(theme.typography.title2)

            Text("Enter the coordinates for the planned fix.")
                .fontStyle(theme.typography.body)

            Text("DDM format required")
                .fontStyle(theme.typography.caption1)
        }
    }
}
```

## Colour Overrides

`FontStyle` carries an optional `foregroundColor`. When `nil`, the view's own `foregroundColor` modifier (or the theme context) controls colour. Override per-style with `.withColor()`:

```swift
Text("CAUTION")
    .fontStyle(theme.typography.bodyBold.withColor(theme.color.caution))
```

## Scaling

The entire typography scale can be proportionally scaled using `ThemeTypographyData.scaled(by:)`. This is primarily used via `ThemeData.scaled(by:)`, which scales spacing, size, radius, and typography together. A scale factor of `0.75` produces a compact display suitable for denser data screens.

```swift
let compactTheme = ThemeData.dark.scaled(by: 0.75)
```

## Accessibility

FlightUI applies `UIFontMetrics` scaling to every `FontStyle` via the `.fontStyle()` modifier. This means all text in the library respects the user's Dynamic Type setting automatically. The scale factors above are base values; the actual rendered size will increase or decrease according to the system accessibility size.

Do not use `Font.system(size:)` directly in components that use FlightUI themes — always use `.fontStyle()` to ensure consistent scaling behaviour.

## Line and Character Spacing

Line spacing values are expressed as **line height minus font size** (the convention from design tools like Figma). This means `lineSpacing: 7` on `largeTitle` (34pt) means the design line height is 41pt.

`callout` is the only scale with non-zero character spacing (+2pt), giving it a tracking effect appropriate for annotation labels.

## When to Use Each Scale

- Use `largeTitle` and `title1` for navigation and screen-level titles only. Never use them for repeated items in a list.
- `headline` is the right choice for any label that needs to stand out from surrounding `body` text without being a structural title.
- `caption1` is the workhorse for input field labels — it reads clearly at 15pt but does not compete with the field value.
- `caption2` at 14pt should be the floor. Below this, text becomes illegible under vibration and in poor cabin lighting.
