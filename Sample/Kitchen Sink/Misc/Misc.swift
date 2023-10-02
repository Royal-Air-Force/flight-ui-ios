import SwiftUI
import FlightUI

struct Misc: View {
    @EnvironmentObject var theme: Theme

    var body: some View {
        ScrollView {
            VStack {
                expandingPanel
                    .padding([.bottom], theme.padding.grid6x)

                nonExpandingPanel
                    .padding([.bottom], theme.padding.grid6x)
            }
        }
        .navigationBarTitle("Misc")
    }

    var expandingPanel: some View {
        Panel(title: "Expandable Panel", options: .expandable(expanded: true)) {
            VStack {
                HStack(alignment: .top) {
                   Text("Lots of lovely panel content")
                    Spacer()
                }
            }
            .padding(theme.padding.grid6x)
        }
    }

    var nonExpandingPanel: some View {
        Panel(title: "Expandable Panel", typography: (theme.font.title1.font)) {
            VStack {
                HStack(alignment: .top) {
                   Text("Lots of lovely panel content")
                    Spacer()
                }
            }
            .padding(theme.padding.grid6x)
        }
    }
}
