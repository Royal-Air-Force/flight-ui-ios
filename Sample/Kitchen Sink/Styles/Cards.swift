import SwiftUI
import FlightUI

struct Cards: View {
    @EnvironmentObject var theme: Theme
    
    var body: some View {
        ScrollView {
            VStack {
                elevatedCard
                filledCard
                outlineCard
            }
        }
        .navigationBarTitle("Cards")
    }
    
    var elevatedCard: some View {
        VStack {
            HeadingView(
                title: "Elevated Card",
                subTitle: "Displays a card surrounded by a shadow")

            VStack(alignment: .leading) {
                Text("Hello")
                    .foregroundColor(theme.color.onSurface.default)
                Text("World")
                    .foregroundColor(theme.color.onSurface.default)
                Text("Elevated")
                    .foregroundColor(theme.color.onSurface.default)
            }
            .padding(theme.padding.grid1x)
            .cardStyle(theme.cards.elevated)
            .padding(theme.padding.grid2x)
        }
    }
    
    var filledCard: some View {
        VStack {
            HeadingView(
                title: "Filled Card",
                subTitle: "Displays a card with no border and no shadow")

            VStack(alignment: .leading) {
                Text("Hello")
                    .foregroundColor(theme.color.onSurface.default)
                Text("World")
                    .foregroundColor(theme.color.onSurface.default)
                Text("Filled")
                    .foregroundColor(theme.color.onSurface.default)
            }
            .padding(theme.padding.grid1x)
            .cardStyle(theme.cards.filled)
            .padding(theme.padding.grid2x)
        }
    }
    
    var outlineCard: some View {
        VStack {
            HeadingView(
                title: "Outline Card",
                subTitle: "Displays a card with a border and no background color")

            VStack(alignment: .leading) {
                Text("Hello")
                    .foregroundColor(theme.color.onSurface.default)
                Text("World")
                    .foregroundColor(theme.color.onSurface.default)
                Text("Outline")
                    .foregroundColor(theme.color.onSurface.default)
            }
            .padding(theme.padding.grid1x)
            .cardStyle(theme.cards.filled)
            .padding(theme.padding.grid2x)
        }
    }
}
