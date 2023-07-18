import SwiftUI
import FlightUI

struct Typography: View {
    @EnvironmentObject var theme: Theme
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text("Large Title/SF Pro/Regular/34px")
                        .fontStyle(theme.font.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.padding.grid1x)
                    
                    Text("Title 1/SF Pro/Regular/28px")
                        .fontStyle(theme.font.title1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.padding.grid1x)
                    
                    Text("Title 2/SF Pro/Regular/22px")
                        .fontStyle(theme.font.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.padding.grid1x)
                    
                    Text("Title 3/SF Pro/Regular/20px")
                        .fontStyle(theme.font.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.padding.grid1x)
                }

                VStack {
                    Text("Headline/SF Pro/Regular/17px")
                        .fontStyle(theme.font.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.padding.grid1x)

                    Text("Body/SF Pro/Regular/17px")
                        .fontStyle(theme.font.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.padding.grid1x)

                    Text("Callout/SF Pro/Regular/16px")
                        .fontStyle(theme.font.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.padding.grid1x)

                    Text("Subhead/SF Pro/Regular/15px")
                        .fontStyle(theme.font.subhead)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.padding.grid1x)
                }

                VStack {
                    Text("Footnote/SF Pro/Regular/14px")
                        .fontStyle(theme.font.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.padding.grid1x)

                    Text("Caption 1/SF Pro/Regular/12px")
                        .fontStyle(theme.font.caption1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.padding.grid1x)

                    Text("Caption 2/SF Pro/Regular/11px")
                        .fontStyle(theme.font.caption2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, theme.padding.grid1x)
                }
            }
            .padding(.horizontal, theme.padding.grid3x)
        }
        .background(theme.color.background)
        .navigationBarTitle("Typography")
    }
}

struct Typography_Previews: PreviewProvider {
    static var previews: some View {
        Typography()
            .environmentObject(Theme())
    }
}
