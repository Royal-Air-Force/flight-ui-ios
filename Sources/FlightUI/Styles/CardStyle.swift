import SwiftUI

// MARK: - Card Shadow

public struct CardShadow: Sendable {
    public let color: Color
    public let radius: CGFloat

    public init(
        color: Color = .black.opacity(0.1),
        radius: CGFloat = 4
    ) {
        self.color = color
        self.radius = radius
    }
}

// MARK: - Card Style

public struct CardStyle: Sendable {
    public let shadow: CardShadow?
    public let backgroundColor: Color?
    public let showBorder: Bool
    public let cardRadius: CGFloat?
    public let cardPadding: CGFloat?

    public init(
        shadow: CardShadow?,
        backgroundColor: Color?,
        showBorder: Bool,
        cardRadius: CGFloat?,
        cardPadding: CGFloat?
    ) {
        self.shadow = shadow
        self.backgroundColor = backgroundColor
        self.showBorder = showBorder
        self.cardRadius = cardRadius
        self.cardPadding = cardPadding
    }
}

// MARK: - CardStyle Factories

extension CardStyle {
    public static var elevated: CardStyle {
        CardStyle(
            shadow: CardShadow(),
            backgroundColor: nil,
            showBorder: false,
            cardRadius: nil,
            cardPadding: 0
        )
    }

    public static var outline: CardStyle {
        CardStyle(
            shadow: nil,
            backgroundColor: .clear,
            showBorder: true,
            cardRadius: nil,
            cardPadding: 0
        )
    }

    public static var filled: CardStyle {
        CardStyle(
            shadow: nil,
            backgroundColor: nil,
            showBorder: false,
            cardRadius: nil,
            cardPadding: 0
        )
    }
}

// MARK: - Card Style Modifier

struct CardStyleModifier: ViewModifier {
    @Environment(\.theme) var theme

    let style: CardStyle

    init(style: CardStyle) {
        self.style = style
    }

    func body(content: Content) -> some View {
        ZStack {
            baseCard
                .ifNotNil(style.shadow) { view, shadow in
                    view.shadow(color: shadow.color, radius: shadow.radius, x: 2, y: 4)
                }
            content
                .padding(style.cardPadding ?? 0)
        }
    }

    @ViewBuilder
    private var baseCard: some View {
        if style.showBorder {
            RoundedRectangle(cornerRadius: style.cardRadius ?? theme.radius.medium, style: .continuous)
                .style(
                    withStroke: theme.color.surfaceLow,
                    lineWidth: theme.size.border,
                    fill: style.backgroundColor ?? theme.color.surfaceLow
                )
        } else {
            RoundedRectangle(cornerRadius: style.cardRadius ?? theme.radius.medium, style: .continuous)
                .fill(style.backgroundColor ?? theme.color.surfaceLow)
        }
    }
}

// MARK: - View Extension

extension View {
    public func cardStyle(_ style: CardStyle) -> some View {
        modifier(CardStyleModifier(style: style))
    }
}
