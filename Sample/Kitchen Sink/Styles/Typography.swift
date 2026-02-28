import SwiftUI
import FlightUI

struct Typography: View {
    @Environment(\.theme) var theme

    let paragraphExample: String =
        """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore \
        et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut \
        aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse \
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, \
        sunt in culpa qui officia deserunt mollit anim id est laborum."
        """

    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text("Large Title | SF Pro | Bold | 34px")
                        .fontStyle(theme.typography.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.spacing.grid1x)

                    Text("Title 1 | SF Pro | Semi Bold | 30px")
                        .fontStyle(theme.typography.title1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.spacing.grid1x)

                    Text("Title 2 | SF Pro | Regular | 28px")
                        .fontStyle(theme.typography.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.spacing.grid1x)

                    Text("Title 3 | SF Pro | Regular | 24px")
                        .fontStyle(theme.typography.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.spacing.grid1x)
                }

                VStack {
                    Text("Headline | SF Pro | Semi Bold | 20px")
                        .fontStyle(theme.typography.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.spacing.grid1x)

                    Text("Subhead | SF Pro | Regular | 18px")
                        .fontStyle(theme.typography.subhead)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.spacing.grid1x)

                    Text("Body | SF Pro | Regular | 16px")
                        .fontStyle(theme.typography.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.spacing.grid1x)

                    Text("Body Bold | SF Pro | Semi Bold | 16px")
                        .fontStyle(theme.typography.bodyBold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.spacing.grid1x)

                    Text("Callout | SF Pro | Semi Bold | 15px")
                        .fontStyle(theme.typography.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.spacing.grid1x)

                    Text("Footnote | SF Pro | Semi Bold | 15px")
                        .fontStyle(theme.typography.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.spacing.grid1x)

                    Text("Caption 1 | SF Pro | Regular | 15px")
                        .fontStyle(theme.typography.caption1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.spacing.grid1x)

                    Text("Caption 2 | SF Pro | Regular | 14px")
                        .fontStyle(theme.typography.caption2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.spacing.grid1x)
                }
            }
            .padding(.horizontal, theme.spacing.grid3x)
        }
        .background(theme.color.background)
        .navigationBarTitle("Typography")
    }
}
