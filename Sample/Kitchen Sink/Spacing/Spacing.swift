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
            HeadingView(
                title: "Padding",
                subTitle: "Used for spacing between components on screen, follows the standard 8pt grid")

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
            HeadingView(
                title: "Sizes",
                subTitle: "Used for managing the size of components themselves")

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
            HeadingView(
                title: "Radius",
                subTitle: "Providing the standard radius used across the apps for corners on components")

            SpacingDisplayBox(name: "Radius Small", space: theme.radius.small)
            SpacingDisplayBox(name: "Radius Medium", space: theme.radius.medium)
            SpacingDisplayBox(name: "Radius Large", space: theme.radius.large)

            HeadingView(
                title: "Inner Radius",
                subTitle: "When a rounded component is inside another rounded component, the corner radius should work well with the parent. " +
                "This is calculated based on the margin between the inner and outer component, the following examples use a value of 8pt padding")

            SpacingDisplayBox(name: "Inner Radius Small", space: theme.radius.innerSmall(padding: 8.0))
            SpacingDisplayBox(name: "Inner Radius Medium", space: theme.radius.innerMedium(padding: 8.0))
            SpacingDisplayBox(name: "Inner Radius Large", space: theme.radius.innerLarge(padding: 8.0))
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
