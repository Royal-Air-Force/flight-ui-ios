import SwiftUI
import FlightUI

struct Spacing: View {
    @EnvironmentObject var theme: Theme
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                padding
                sizes
                radius
            }
            .padding(.horizontal, theme.padding.grid3x)
        }
        .background(theme.color.background)
        .navigationBarTitle("Spacing")
    }
    
    var padding: some View {
        VStack {
            Text("Padding")
                .fontStyle(theme.font.title1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Used for spacing between components on screen, follows the standard 8pt grid")
                .fontStyle(theme.font.caption1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            
            VStack {
                SpacingDisplayBox(name: "Grid 0.5x", space: theme.padding.grid0_5x)
                SpacingDisplayBox(name: "Grid 1x", space: theme.padding.grid1x)
                SpacingDisplayBox(name: "Grid 1.5x", space: theme.padding.grid1_5x)
                SpacingDisplayBox(name: "Grid 2x", space: theme.padding.grid2x)
                SpacingDisplayBox(name: "Grid 3x", space: theme.padding.grid3x)
                SpacingDisplayBox(name: "Grid 4x", space: theme.padding.grid4x)
            }
            VStack {
                SpacingDisplayBox(name: "Grid 5x", space: theme.padding.grid5x)
                SpacingDisplayBox(name: "Grid 6x", space: theme.padding.grid6x)
                SpacingDisplayBox(name: "Grid 7x", space: theme.padding.grid7x)
                SpacingDisplayBox(name: "Grid 8x", space: theme.padding.grid8x)
                SpacingDisplayBox(name: "Grid 9x", space: theme.padding.grid9x)
                SpacingDisplayBox(name: "Grid 10x", space: theme.padding.grid10x)
            }
        }
    }
    
    var sizes: some View {
        VStack {
            Text("Sizes")
                .fontStyle(theme.font.title1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Used for managing the size of components themselves")
                .fontStyle(theme.font.caption1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            
            VStack {
                SpacingDisplayBox(name: "Divider", space: theme.size.divider)
                SpacingDisplayBox(name: "Icon Small", space: theme.size.iconSmall)
                SpacingDisplayBox(name: "Icon Medium", space: theme.size.iconMedium)
                SpacingDisplayBox(name: "Icon Large", space: theme.size.iconLarge)
            }
            VStack {
                SpacingDisplayBox(name: "Small", space: theme.size.small)
                SpacingDisplayBox(name: "Medium", space: theme.size.medium)
                SpacingDisplayBox(name: "Large", space: theme.size.large)
                SpacingDisplayBox(name: "XLarge", space: theme.size.xLarge)
                SpacingDisplayBox(name: "XXLarge", space: theme.size.xxLarge)
                SpacingDisplayBox(name: "XXXLarge", space: theme.size.xxxLarge)
            }
        }
    }
    
    var radius: some View {
        VStack {
            Text("Radius")
                .fontStyle(theme.font.title1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Providing the standard radius used across the apps for corners on components")
                .fontStyle(theme.font.caption1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            
            SpacingDisplayBox(name: "Radius Small", space: theme.radius.small)
            SpacingDisplayBox(name: "Radius Medium", space: theme.radius.medium)
            SpacingDisplayBox(name: "Radius Large", space: theme.radius.large)
        }
    }
}

struct SpacingDisplayBox: View {
    @EnvironmentObject var theme: Theme
    
    var name: String
    var space: CGFloat
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(theme.color.onBackground.default)
                .frame(width: space, height: space, alignment: .leading)
                .padding(theme.padding.grid1x)
            Text("\(name) - \(String(format: "%.0f", space))pt")
                .fontStyle(theme.font.body)
                .padding(theme.padding.grid1x)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
