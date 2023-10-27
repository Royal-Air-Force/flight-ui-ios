import SwiftUI
import FlightUI

struct Buttons: View {
    @EnvironmentObject var theme: Theme
    @StateObject private var viewModel = ViewModel()
    
    @State private var showingAlert = false

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
                coreButton
            }
            .padding(.horizontal, theme.padding.grid3x)
        }
        .background(theme.color.background)
        .navigationBarTitle("Buttons")
    }

    var filledButton: some View {
        VStack {
            HeadingView(title: "Filled Button", subTitle: "The filled button has the most visual impact and should be used for important, final actions within a flow")

            HStack {
                Button("Enabled", action: { showingAlert = true })
                    .buttonStyle(.filled)
                    .padding([.trailing], theme.padding.grid2x)
                    .alert("Important message", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
                    }

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
            HeadingView(
                title: "Tonal Button",
                subTitle: "The tonal button has less emphasis than filled but still provides visual importance, and should be used for non-final actions in a flow such as 'Next'")

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
            HeadingView(
                title: "Outline Button",
                subTitle: "The outline button has low emphasis within the UI and often paired with a filled/tonal button to indicate a secondary action on screen")

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
            HeadingView(
                title: "Text Button",
                subTitle: "The text button is the lowest priority action and don't distract from nearby content they don't have a container, often used for presenting a number of low priority actions"
            )

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
    
    var coreButton: some View {
        VStack {
            HeadingView(title: "Core Button", subTitle: "Core buttons are specific to the flight crew alerting context, they should be used sparingly and only when directly related to an advisory, caution, or warning state")
            
            Grid(alignment: .leading) {
                GridRow {
                    Button("Advisory", action: { print("Advisory Tapped") })
                        .buttonStyle(.advisory)
                        .padding([.trailing], theme.padding.grid2x)

                    Button {} label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Advisory w/ Icon")
                        }
                    }.buttonStyle(.advisory)
                        .padding([.trailing], theme.padding.grid2x)

                    Button("Advisory Disabled", action: {})
                        .buttonStyle(.advisory)
                        .padding([.trailing], theme.padding.grid2x)
                        .disabled(true)
                }
                GridRow {
                    Button("Caution", action: { print("Caution Tapped") })
                        .buttonStyle(.caution)
                        .padding([.trailing], theme.padding.grid2x)

                    Button {} label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Caution w/ Icon")
                        }
                    }.buttonStyle(.caution)
                        .padding([.trailing], theme.padding.grid2x)

                    Button("Caution Disabled", action: {})
                        .buttonStyle(.caution)
                        .padding([.trailing], theme.padding.grid2x)
                        .disabled(true)
                }
                GridRow {
                    Button("Warning", action: { print("Warning Tapped") })
                        .buttonStyle(.warning)
                        .padding([.trailing], theme.padding.grid2x)

                    Button {} label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Warning w/ Icon")
                        }
                    }.buttonStyle(.warning)
                        .padding([.trailing], theme.padding.grid2x)

                    Button("Warning Disabled", action: {})
                        .buttonStyle(.warning)
                        .padding([.trailing], theme.padding.grid2x)
                        .disabled(true)
                }
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
