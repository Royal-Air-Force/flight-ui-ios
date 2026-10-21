# 🔭 Spacing

FlightUI uses an **8pt grid system** — all spacing values are multiples of 8pt (with a 4pt half-step at the bottom of the scale). This produces consistent, harmonious layouts across components and screens without ad hoc numbers.

All spacing values are accessed from the theme: `theme.spacing.grid4x`, etc. Never use raw integer padding values in components — always reference the grid.

## The Grid

| Token | Standard | Compact | Use for |
|-------|----------|---------|---------|
| `grid0_5x` | 4pt | 2pt | Minimum separation. Tight spacing between a label and its icon; internal chip padding. |
| `grid1x` | 8pt | 4pt | Default spacing between related elements within a component. |
| `grid1_5x` | 12pt | 6pt | Small inset padding. Internal component padding when space is constrained. |
| `grid2x` | 16pt | 8pt | Standard inset padding for cards and panels. Default horizontal content margin. |
| `grid2_5x` | 20pt | 10pt | Vertical separation between form fields. |
| `grid3x` | 24pt | 12pt | Separation between sections within a screen. |
| `grid4x` | 32pt | 16pt | Button horizontal padding; major section spacing. |
| `grid5x` | 40pt | 20pt | Large section separation; hero spacing. |
| `grid6x` | 48pt | 24pt | Navigation bar heights and equivalents. |
| `grid7x` | 56pt | 28pt | Large vertical spacing between major screen areas. |
| `grid8x` | 64pt | 32pt | Full-screen inset margins. |
| `grid9x` | 72pt | 36pt | Extra large screen-level spacing. |
| `grid10x` | 80pt | 40pt | Maximum standard spacing. |

## Usage

```swift
struct MyView: View {
    @Environment(\.theme) var theme

    var body: some View {
        VStack(spacing: theme.spacing.grid2_5x) {
            InputField(text: $lat, placeholder: "Latitude")
            InputField(text: $lon, placeholder: "Longitude")
        }
        .padding(.horizontal, theme.spacing.grid2x)
        .padding(.vertical, theme.spacing.grid3x)
    }
}
```

## Compact Mode

The `compact` spacing configuration halves all values and is intended for screens that need to display a large number of parameters simultaneously — performance dashboards, FMS-style result tables, and instrument read-outs. Switch to compact spacing via `ThemeData.scaled(by:)` or `withSpacing(.compact)`:

```swift
// Half-scale everything
let compactTheme = ThemeData.dark.scaled(by: 0.5)

// Compact spacing only, keep other dimensions standard
let denseTheme = ThemeData.dark.withSpacing(.compact)
```

Do not mix compact and standard spacing within the same level of a hierarchy. Either a whole screen is compact, or it is standard.

## Custom Scales

For bespoke density requirements, create a custom `ThemeSpacingData`:

```swift
let customSpacing = ThemeSpacingData(
    grid0_5x: 3,
    grid1x: 6,
    // ... all 13 values required
)
let customTheme = ThemeData.dark.withSpacing(customSpacing)
```

## Why 8pt?

The 8pt grid aligns with iOS point sizes, which map to whole pixel boundaries on all modern Retina display densities (2× and 3×). This means spacing values never produce sub-pixel rendering artefacts. In an aviation context — where displays may be viewed at an angle, in turbulence, under variable lighting — eliminating rendering artefacts is a meaningful reliability concern.

The 4pt half-step (`grid0_5x`) is reserved for tight internal component spacing only. It should not be used for layout-level separation between components.

## Relationship to `ThemeSizeData`

Spacing governs the **gaps between and around** elements. `ThemeSizeData` governs the **intrinsic dimensions of** elements — icon sizes, component heights, border widths. The two systems are complementary: use spacing for padding and margins, use size tokens for fixed component dimensions.
