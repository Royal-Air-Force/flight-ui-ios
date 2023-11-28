//
//  CardStyle.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

private class Defaults {
    static let shadowRadius: CGFloat = 4
}

public class CardStyle {

    private var id: UUID
    public var shadow: CardShadow?
    public var backgroundColor: Color?
    public var showBorder: Bool
    public var cardRadius: CGFloat?
    public var cardPadding: CGFloat?

    public init(shadow: CardShadow?, backgroundColor: Color?, showBorder: Bool, cardRadius: CGFloat?, cardPadding: CGFloat?) {
        self.id = UUID()
        self.shadow = shadow
        self.backgroundColor = backgroundColor
        self.showBorder = showBorder
        self.cardRadius = cardRadius
        self.cardPadding = cardPadding
    }
}

public struct CardShadow {
    var color: Color
    var radius: CGFloat

    init(color: Color = .black.opacity(0.1), radius: CGFloat = Defaults.shadowRadius) {
        self.color = color
        self.radius = radius
    }
}

struct CardStyleModifier: ViewModifier {
    @EnvironmentObject var theme: Theme

    let style: CardStyle

    init(style: CardStyle) {
        self.style = style
    }

    func body(content: Content) -> some View {
        ZStack {
            getBaseCard()
                .ifNotNil(style.shadow, transform: { view, shadow in
                    view.shadow(color: shadow.color, radius: shadow.radius, x: 2, y: 4)
                })
            content
                .padding(style.cardPadding ?? 0)
        }
    }

    @ViewBuilder
    private func getBaseCard() -> some View {
        if style.showBorder {
            RoundedRectangle(cornerRadius: style.cardRadius ?? theme.radius.medium, style: .continuous)
                .style(
                    withStroke: theme.color.surfaceLow,
                    lineWidth: theme.size.border,
                    fill: style.backgroundColor ?? theme.color.surfaceLow)
        } else {
            RoundedRectangle(cornerRadius: style.cardRadius ?? theme.radius.medium, style: .continuous)
                .fill(style.backgroundColor ?? theme.color.surfaceLow)
        }
    }
}

extension View {
    public func cardStyle(_ style: CardStyle) -> some View {
        modifier(CardStyleModifier(style: style))
    }
}

#if DEBUG

struct CardStyle_Previews: PreviewProvider {
    static var theme: Theme = Theme(baseScheme: .dark)

    static var previews: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid2x) {
            HStack {
                Text("Elevated Card")
            }
            .cardStyle(.elevated)

            HStack {
                Text("Filled Card")
            }
            .cardStyle(.filled)

            HStack {
                Text("Outline Card")
            }
            .cardStyle(.outline)
        }
        .environmentObject(theme)
        .previewDisplayName("Card Style")
        .preferredColorScheme(theme.baseScheme)
    }
}

#endif
