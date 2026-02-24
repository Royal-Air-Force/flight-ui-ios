# 💳 Cards

Cards are surface containers that group related content and separate it visually from the rest of the screen. FlightUI provides three card styles and a `Panel` component for headed containers with optional collapsible behaviour.

## When to Use Cards

Cards are appropriate when content needs to be scanned quickly and independently of surrounding content — a parameter summary, a waypoint detail, or a checklist group. They are not appropriate for wrapping the entire screen, for a single isolated value, or for lists of homogeneous items where a divider is sufficient.

## Card Styles

Apply with the `.cardStyle()` view modifier.

### `elevated`

A shadow-only card with no border. Use when the card sits directly on the `background` colour and needs to lift off the surface visually. The best choice for primary content cards on a plain background.

```swift
VStack { ... }
    .cardStyle(.elevated)
```

### `filled`

A solid `surfaceLow` background with no shadow or border. Use inside panels, bottom sheets, or anywhere the background is already differentiated. The default interior surface for grouped parameter displays.

```swift
VStack { ... }
    .cardStyle(.filled)
```

### `outline`

A border-only card with a transparent background. Use when you want to delineate a region without adding visual weight — for example, a selection state or an optional section that may or may not contain content.

```swift
VStack { ... }
    .cardStyle(.outline)
```

### Custom

All card properties are configurable via `CardStyle(shadow:backgroundColor:showBorder:cardRadius:cardPadding:)`. Use this when the three standard styles do not meet a specific layout requirement.

```swift
VStack { ... }
    .cardStyle(CardStyle(
        shadow: CardShadow(color: .black.opacity(0.2), radius: 8),
        backgroundColor: theme.color.surfaceHigh,
        showBorder: true,
        cardRadius: theme.radius.large,
        cardPadding: theme.spacing.grid2x
    ))
```

## Panel

`Panel` is a headed card with an optional expand/collapse behaviour. Use it wherever a section has a title and content that should be grouped under it.

```swift
// Fixed panel — always shows content
Panel(title: "Navigation Fix") {
    DataRow(label: "Lat", value: "N 51° 28.741'")
    DataRow(label: "Lon", value: "W 000° 27.582'")
}

// Expandable panel — collapsed by default
Panel(title: "Advanced Options", options: .expandable(expanded: false)) {
    // ... content
}

// Expandable — open by default
Panel(title: "Summary", options: .expandable(expanded: true)) {
    // ... content
}
```

### Panel with Subtitle

The subtitle appears in the header, trailing the title. Use it for a summary value or status badge that is visible even when the panel is collapsed.

```swift
Panel(title: "Fuel") {
    subtitle: {
        StatusBadge("LOW", state: .caution)
    }
    content: {
        // ... detailed rows
    }
}
```

### Typography Override

The panel title uses `Font.title2` by default. Pass a `typography` parameter to override:

```swift
Panel(title: "Waypoints", typography: .headline) {
    // ...
}
```

## Nesting

Cards should not be nested more than one level deep. A panel containing `filled` cards is the standard maximum depth. Beyond that, the visual hierarchy becomes difficult to parse quickly — a critical failure mode in aviation UI.

## Corner Radius

All card styles use `theme.radius.medium` by default. This can be overridden per card via `CardStyle`'s `cardRadius` parameter. The inner content of a card should use `theme.radius.innerMedium(padding:)` for any nested rounded shapes to maintain visual consistency.
