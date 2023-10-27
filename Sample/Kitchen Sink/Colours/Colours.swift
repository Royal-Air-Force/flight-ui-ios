import SwiftUI
import FlightUI

struct Colours: View {
    @EnvironmentObject var theme: Theme
    @StateObject private var viewModel = ViewModel()

    fileprivate let boxMinHeight: CGFloat = 126
    fileprivate let boxIdealWidth: CGFloat = 194

    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                backgroundColors
                foregroundColors
                coreColors
                graphicsColors
            }
            .padding(.horizontal, theme.padding.grid3x)
        }
        .background(theme.color.background)
        .navigationBarTitle("Colours")
    }

    var backgroundColors: some View {
        VStack {
            HeadingView(
                title: "General colours",
                subTitle: "Used for distinguishing content and content areas within an application")

            ColorView(colorName: "Background",
                      colorDescription: "Default colour for every screen background",
                      colorValue: theme.color.background)
            Spacer()

            ColorView(colorName: "Surface Low",
                      colorDescription: "Background colour for structural components such as cards and bottom sheets",
                      colorValue: theme.color.surfaceLow)
            Spacer()

            ColorView(colorName: "Surface High",
                      colorDescription: "Colour for component surfaces closer to the user such as text fields and alert dialogs",
                      colorValue: theme.color.surfaceHigh)
        }
    }

    var foregroundColors: some View {
        VStack {
            ColorView(colorName: "Primary",
                      colorDescription: "Default colour for all content including text, icons, and non-context based components",
                      colorValue: theme.color.primary)
            Spacer()

            ColorView(colorName: "Secondary",
                      colorDescription: "Colour with lower priority for content, such as subtitles or unselected components",
                      colorValue: theme.color.secondary)
            Spacer()

            ColorView(colorName: "Disabled",
                      colorDescription: "Colour for all disabled components including button backgrounds, input field backgrounds, etc",
                      colorValue: theme.color.disabled)
            Spacer()

            ColorView(colorName: "On Disabled",
                      colorDescription: "Colour for disabled content on top of a disabled component for example the the button text on top of a disabled background etc",
                      colorValue: theme.color.onDisabled)
        }
        .padding(.bottom, theme.padding.grid2x)
    }

    var coreColors: some View {
        VStack {
            HeadingView(
                title: "Core colours",
                subTitle: "Used to bring context to an app such as indicating user input or success states")

            ColorView(colorName: "Input Output",
                      colorDescription: "Colour used to indicate required input or output for a user",
                      colorValue: theme.color.inputOutput)
            Spacer()

            ColorView(colorName: "Nominal",
                      colorDescription: "Colour to indicate general success or a safe action such as proceeding in a flow",
                      colorValue: theme.color.nominal)
            Spacer()

            ColorView(colorName: "Caution",
                      colorDescription: "Colour to indicate a non-severe warning, such as continuing with data input that is technically valid but requires expertise and confirmation",
                      colorValue: theme.color.caution)
            Spacer()

            ColorView(colorName: "Warning",
                      colorDescription: "Colour to be used very sparingly, and indicates a severe or potential risk to life error within it's use case",
                      colorValue: theme.color.warning)
            Spacer()

            ColorView(colorName: "On Core",
                      colorDescription: "Default colour to display components such as text on top of any of the other core colours",
                      colorValue: theme.color.onCore)
        }
        .padding(.bottom, theme.padding.grid2x)
    }

    var graphicsColors: some View {
        VStack {
            HeadingView(
                title: "Graphics colours",
                subTitle: "Only to be used for displaying complex data sets such as graphs and diagrams")

            VStack {
                SimpleColorView(colorName: "Graphics Red", colorValue: theme.color.graphicsRed)
                SimpleColorView(colorName: "Graphics Yellow", colorValue: theme.color.graphicsYellow)
                SimpleColorView(colorName: "Graphics Green", colorValue: theme.color.graphicsGreen)
                SimpleColorView(colorName: "Graphics Mint", colorValue: theme.color.graphicsMint)
                SimpleColorView(colorName: "Graphics Cyan", colorValue: theme.color.graphicsCyan)
            }
            VStack {
                SimpleColorView(colorName: "Graphics Blue", colorValue: theme.color.graphicsBlue)
                SimpleColorView(colorName: "Graphics Indigo", colorValue: theme.color.graphicsIndigo)
                SimpleColorView(colorName: "Graphics Purple", colorValue: theme.color.graphicsPurple)
                SimpleColorView(colorName: "Graphics Pink", colorValue: theme.color.graphicsPink)
            }
        }
        .padding(.bottom, theme.padding.grid2x)
    }
}

struct ColorView: View {

    @EnvironmentObject var theme: Theme

    var colorName: String
    var colorDescription: String
    var colorValue: Color

    var body: some View {
        HStack {
            Rectangle()
                .fill(colorValue)
                .border(theme.color.surfaceLow)
                .frame(width: 80, height: 60)

            VStack {
                Text("\(colorName) - \(colorValue.hexaRGBA?.uppercased() ?? "")")
                    .foregroundColor(theme.color.primary)
                    .fontStyle(theme.font.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(colorDescription)")
                    .foregroundColor(theme.color.secondary)
                    .fontStyle(theme.font.caption1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, theme.padding.grid1x)
        }
        .padding([.top, .bottom], theme.padding.grid0_5x)
    }
}

struct SimpleColorView: View {
    @EnvironmentObject var theme: Theme

    var colorName: String
    var colorValue: Color

    var body: some View {
        HStack {
            Rectangle()
                .fill(colorValue)
                .border(theme.color.surfaceLow)
                .frame(width: 80, height: 30)

            VStack {
                Text("\(colorName) - \(colorValue.hexaRGBA?.uppercased() ?? "")")
                    .foregroundColor(theme.color.primary)
                    .fontStyle(theme.font.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, theme.padding.grid1x)
        }
        .padding([.top, .bottom], theme.padding.grid0_5x)
    }
}

struct Colours_Previews: PreviewProvider {
    static var previews: some View {
        Colours()
            .environmentObject(Theme())

    }
}
