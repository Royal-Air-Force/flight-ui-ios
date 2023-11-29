//
//  Misc.swift
//  Flight UI - Kitchen Sink Sample
//
//  Created by Appivate 2023
//

import SwiftUI
import FlightUI

struct Misc: View {
    @EnvironmentObject var theme: Theme

    var body: some View {
        ScrollView {
            VStack {
//                expandingPanel
//                    .padding([.bottom], theme.padding.grid6x)
//
//                nonExpandingPanel
//                    .padding([.bottom], theme.padding.grid6x)

                expandingCard
            }
        }
        .navigationBarTitle("Misc")
    }

//    var expandingPanel: some View {
//        Panel(title: "Expandable Panel", options: .expandable(expanded: true)) {
//            VStack {
//                HStack(alignment: .top) {
//                    Text("Lots of lovely panel content")
//                    Spacer()
//                }
//            }
//            .padding(theme.padding.grid6x)
//        }
//    }
//
//    var nonExpandingPanel: some View {
//        Panel(title: "Expandable Panel", typography: (Font.title)) {
//            VStack {
//                HStack(alignment: .top) {
//                    Text("Lots of lovely panel content")
//                    Spacer()
//                }
//            }
//            .padding(theme.padding.grid6x)
//        }
//    }

    // Expanding panels will become cards at some point, similar to below, some style tweaking still needed
    @State private var isExpandedCardExpanded = false
    var expandingCard: some View {
        VStack(alignment: .leading) {
            HeadingView(
                title: "Expanding Card",
                subTitle: "Displays a card capable of expanding and contracting for additional content")

            DisclosureGroup(isExpanded: $isExpandedCardExpanded) {
                VStack(alignment: .leading) {
                    Text("Hidden Content")
                        .fontStyle(.title1)
                        .padding([.leading, .trailing], theme.padding.grid2x)
                        .padding([.top, .bottom], theme.padding.grid1x)
                    Text("Card style can be used around various components including a disclosure group, allowing efficient expandable cards")
                        .fontStyle(.body)
                        .padding([.leading, .trailing], theme.padding.grid2x)
                        .padding(.bottom, theme.padding.grid1x)
                }
                .frame(maxWidth: .infinity)
                .cornerRadius(theme.radius.large)
                .background(theme.color.background)
            } label: {
                HStack {
                    Text("Expanding Card")
                        .fontStyle(.headline)
                }
                .frame(maxWidth: .infinity, minHeight: theme.size.large, alignment: .leading)
            }
            .padding(theme.size.border)
            .background(theme.color.surfaceLow)
            .cardStyle(theme.cards.outline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, theme.padding.grid2x)
        }
    }
}
