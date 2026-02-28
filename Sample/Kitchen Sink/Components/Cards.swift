import SwiftUI
import FlightUI

struct Cards: View {
    @Environment(\.theme) var theme

    var body: some View {
        ScrollView {
            VStack {
                elevatedCard
                filledCard
                outlineCard
                customColourCard
            }
            .padding(.horizontal, theme.spacing.grid3x)
        }
        .background(theme.color.background)
        .navigationBarTitle("Cards")
    }

    var elevatedCard: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "Elevated Card",
                subTitle: "Displays a card surrounded by a shadow")

            VStack(alignment: .leading, spacing: theme.spacing.grid1x) {
                Image("AppIconImage")
                    .resizable()
                    .clipCorners(theme.radius.medium, corners: [.topLeft, .topRight])
                    .frame(width: 200, height: 200)

                Text("Elevated Card")
                    .foregroundColor(theme.color.primary)
                    .fontStyle(.title1)
                    .padding([.leading, .trailing], theme.spacing.grid2x)
                Text("Displays a card surrounded by a shadow")
                    .foregroundColor(theme.color.secondary)
                    .fontStyle(.body)
                    .padding([.leading, .trailing, .bottom], theme.spacing.grid2x)
            }
            .cardStyle(theme.cards.elevated)
            .frame(width: 200)
            .padding(.vertical, theme.spacing.grid2x)
        }
    }

    var filledCard: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "Filled Card",
                subTitle: "Displays a card with no border and no shadow")

            VStack(alignment: .leading, spacing: theme.spacing.grid1x) {
                Image("AppIconImage")
                    .resizable()
                    .clipCorners(theme.radius.medium, corners: [.topLeft, .topRight])
                    .frame(width: 200, height: 200)

                Text("Filled Card")
                    .foregroundColor(theme.color.primary)
                    .fontStyle(.title1)
                    .padding([.leading, .trailing], theme.spacing.grid2x)
                Text("Displays a card with no border and no shadow")
                    .foregroundColor(theme.color.secondary)
                    .fontStyle(.body)
                    .padding([.leading, .trailing, .bottom], theme.spacing.grid2x)
            }
            .cardStyle(theme.cards.filled)
            .frame(width: 200)
            .padding(.vertical, theme.spacing.grid2x)
        }
    }

    var outlineCard: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "Outline Card",
                subTitle: "Displays a card with a border and no background color")

            VStack(alignment: .leading, spacing: theme.spacing.grid1x) {
                Image("AppIconImage")
                    .resizable()
                    .clipCorners(theme.radius.medium, corners: [.topLeft, .topRight])
                    .frame(width: 200, height: 200)

                Text("Outline Card")
                    .foregroundColor(theme.color.primary)
                    .fontStyle(.title1)
                    .padding([.leading, .trailing], theme.spacing.grid2x)
                Text("Displays a card with a border and no background color")
                    .foregroundColor(theme.color.secondary)
                    .fontStyle(.body)
                    .padding([.leading, .trailing, .bottom], theme.spacing.grid2x)
            }
            .cardStyle(theme.cards.outline)
            .frame(width: 200)
            .padding(.vertical, theme.spacing.grid2x)
        }
    }

    var customColourCard: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "Custom Card",
                subTitle: "Displays a card with custom styling such as the background colour and corner radius")

            VStack(alignment: .leading, spacing: theme.spacing.grid1x) {
                Image("AppIconImage")
                    .resizable()
                    .clipCorners(theme.radius.medium, corners: [.topLeft, .topRight])
                    .frame(width: 200, height: 200)

                Text("Custom Card")
                    .foregroundColor(theme.color.onCore)
                    .fontStyle(.title1)
                    .padding([.leading, .trailing], theme.spacing.grid2x)
                Text("Displays a card with custom styling such as the background colour, corner radius, and inner padding")
                    .foregroundColor(theme.color.onCore)
                    .fontStyle(.body)
                    .padding([.leading, .trailing], theme.spacing.grid2x)
                    .padding(.bottom, theme.spacing.grid1x)
            }
            .cardStyle(CardStyle(shadow: nil, backgroundColor: theme.color.inputOutput, showBorder: false, cardRadius: theme.radius.large, cardPadding: theme.spacing.grid1x))
            .frame(width: 216)
            .padding(.vertical, theme.spacing.grid2x)
        }
    }

}
