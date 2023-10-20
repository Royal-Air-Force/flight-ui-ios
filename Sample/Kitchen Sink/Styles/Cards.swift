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
                customColourCard
            }
            .padding(.horizontal, theme.padding.grid3x)
        }
        .background(theme.color.background)
        .navigationBarTitle("Cards")
    }
    
    var elevatedCard: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "Elevated Card",
                subTitle: "Displays a card surrounded by a shadow")

            VStack(alignment: .leading) {
                Image(uiImage: UIImage(named: "AppIcon")!)
                    .resizable()
                    .clipCorners(theme.radius.medium, corners: [.topLeft, .topRight])
                    .frame(width: 200, height: 200)
                
                Text("Elevated Card")
                    .foregroundColor(theme.color.onSurface.default)
                    .fontStyle(.title1)
                    .padding([.leading, .trailing], theme.padding.grid2x)
                    .padding([.top, .bottom], theme.padding.grid1x)
                Text("Displays a card surrounded by a shadow")
                    .foregroundColor(theme.color.onSurface.default)
                    .fontStyle(.body)
                    .padding([.leading, .trailing, .bottom], theme.padding.grid2x)
            }
            .cardStyle(theme.cards.elevated)
            .frame(width: 200)
            .padding(.vertical, theme.padding.grid2x)
        }
    }
    
    var filledCard: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "Filled Card",
                subTitle: "Displays a card with no border and no shadow")

            VStack(alignment: .leading) {
                Image(uiImage: UIImage(named: "AppIcon")!)
                    .resizable()
                    .clipCorners(theme.radius.medium, corners: [.topLeft, .topRight])
                    .frame(width: 200, height: 200)
                
                Text("Filled Card")
                    .foregroundColor(theme.color.onSurface.default)
                    .fontStyle(.title1)
                    .padding([.leading, .trailing], theme.padding.grid2x)
                    .padding([.top, .bottom], theme.padding.grid1x)
                Text("Displays a card with no border and no shadow")
                    .foregroundColor(theme.color.onSurface.default)
                    .fontStyle(.body)
                    .padding([.leading, .trailing, .bottom], theme.padding.grid2x)
            }
            .cardStyle(theme.cards.filled)
            .frame(width: 200)
            .padding(.vertical, theme.padding.grid2x)
        }
    }
    
    var outlineCard: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "Outline Card",
                subTitle: "Displays a card with a border and no background color")

            VStack(alignment: .leading) {
                Image(uiImage: UIImage(named: "AppIcon")!)
                    .resizable()
                    .clipCorners(theme.radius.medium, corners: [.topLeft, .topRight])
                    .frame(width: 200, height: 200)
                
                Text("Outline Card")
                    .foregroundColor(theme.color.onBackground.default)
                    .fontStyle(.title1)
                    .padding([.leading, .trailing], theme.padding.grid2x)
                    .padding([.top, .bottom], theme.padding.grid1x)
                Text("Displays a card with a border and no background color")
                    .foregroundColor(theme.color.onBackground.default)
                    .fontStyle(.body)
                    .padding([.leading, .trailing, .bottom], theme.padding.grid2x)
            }
            .cardStyle(theme.cards.outline)
            .frame(width: 200)
            .padding(.vertical, theme.padding.grid2x)
        }
    }
    
    var customColourCard: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "Custom Card",
                subTitle: "Displays a card with custom styling such as the background colour and corner radius")

            VStack(alignment: .leading) {
                Image(uiImage: UIImage(named: "AppIcon")!)
                    .resizable()
                    .clipCorners(theme.radius.innerLarge(padding: theme.padding.grid1x), corners: [.allCorners])
                    .frame(width: 200, height: 200)
                
                Text("Custom Card")
                    .foregroundColor(theme.color.onInputOutput.default)
                    .fontStyle(.title1)
                    .padding([.leading, .trailing], theme.padding.grid2x)
                    .padding([.top, .bottom], theme.padding.grid1x)
                Text("Displays a card with custom styling such as the background colour, corner radius, and inner padding")
                    .foregroundColor(theme.color.onInputOutput.default)
                    .fontStyle(.body)
                    .padding([.leading, .trailing], theme.padding.grid2x)
                    .padding(.bottom, theme.padding.grid1x)
            }
            .cardStyle(CardStyle(shadow: nil, backgroundColor: theme.color.inputOutput.default, showBorder: false, cardRadius: theme.radius.large, cardPadding: theme.padding.grid1x))
            .frame(width: 216)
            .padding(.vertical, theme.padding.grid2x)
        }
    }
}
