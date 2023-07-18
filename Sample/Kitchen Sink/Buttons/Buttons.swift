import SwiftUI
import FlightUI

struct Buttons: View {
    @EnvironmentObject var theme: Theme
    @StateObject private var viewModel = ViewModel()

    fileprivate let boxMinHeight: CGFloat = 126
    fileprivate let boxIdealWidth: CGFloat = 194

    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                filledButton
                tonalButton
                outlinedButton
                textButton
            }
            .padding(.horizontal, theme.padding.grid3x)
        }
        .background(theme.color.background)
        .navigationBarTitle("Buttons")
    }

    var filledButton: some View {
        VStack {
            Text("Filled Button")
                .fontStyle(theme.font.title1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("The filled button has the most visual impact and should be used for important, final actions within a flow")
                .fontStyle(theme.font.caption1)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Button("Enabled", action: { print("Button tapped") })
                    .buttonStyle(.filled)
                    .padding([.trailing], theme.padding.grid2x)

                Button {} label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("With Icon")
                    }
                }.buttonStyle(.filled)
                    .padding([.trailing], theme.padding.grid2x)

                Button("Disabled", action: {})
                    .buttonStyle(.filled)
                    .padding([.trailing], theme.padding.grid2x)
                    .disabled(true)

                Button {} label: {
                    Image(systemName: "plus")
                }.buttonStyle(.filledIcon)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, theme.padding.grid1x)
        }
        .padding(.bottom, theme.padding.grid4x)
    }

    var tonalButton: some View {
        VStack {
            Text("Tonal Button")
                .fontStyle(theme.font.title1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("The tonal button has less emphasis than filled but still provides visual importance, and should be used for non-final actions in a flow such as 'Next'")
                .fontStyle(theme.font.caption1)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Button("Enabled", action: { print("Button tapped") })
                    .buttonStyle(.tonal)
                    .padding([.trailing], theme.padding.grid2x)

                Button {} label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("With Icon")
                    }
                }.buttonStyle(.tonal)
                    .padding([.trailing], theme.padding.grid2x)

                Button("Disabled", action: {})
                    .buttonStyle(.tonal)
                    .padding([.trailing], theme.padding.grid2x)
                    .disabled(true)

                Button {} label: {
                    Image(systemName: "plus")
                }.buttonStyle(.tonalIcon)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, theme.padding.grid1x)
        }
        .padding(.bottom, theme.padding.grid4x)
    }

    var outlinedButton: some View {
        VStack {
            Text("Outlined Button")
                .fontStyle(theme.font.title1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("The outline button has low emphasis within the UI and often paired with a filled/tonal button to indicate a secondary action on screen")
                .fontStyle(theme.font.caption1)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Button("Enabled", action: { print("Button tapped") })
                    .buttonStyle(.outline)
                    .padding([.trailing], theme.padding.grid2x)

                Button {} label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("With Icon")
                    }
                }.buttonStyle(.outline)
                    .padding([.trailing], theme.padding.grid2x)

                Button("Disabled", action: {})
                    .buttonStyle(.outline)
                    .padding([.trailing], theme.padding.grid2x)
                    .disabled(true)

                Button {} label: {
                    Image(systemName: "plus")
                }.buttonStyle(.outlineIcon)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, theme.padding.grid1x)
        }
        .padding(.bottom, theme.padding.grid4x)
    }

    var textButton: some View {
        VStack {
            Text("Text Button")
                .fontStyle(theme.font.title1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("The text button is the lowest priority action on screen and as they don't have a container don't distract from nearby content, often used for presenting a number of low priority actions")
                .fontStyle(theme.font.caption1)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Button("Enabled", action: { print("Button tapped") })
                    .buttonStyle(.text)
                    .padding([.trailing], theme.padding.grid2x)

                Button {} label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("With Icon")
                    }
                }.buttonStyle(.text)
                    .padding([.trailing], theme.padding.grid2x)

                Button("Disabled", action: {})
                    .buttonStyle(.text)
                    .padding([.trailing], theme.padding.grid2x)
                    .disabled(true)

                Button {} label: {
                    Image(systemName: "plus")
                }.buttonStyle(.textIcon)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, theme.padding.grid1x)
        }
        .padding(.bottom, theme.padding.grid4x)
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
            .environmentObject(Theme())
    }
}
