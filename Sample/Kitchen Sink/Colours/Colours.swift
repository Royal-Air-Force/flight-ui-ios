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
                generalColors
                coreColors
                graphicsColors
            }
            .padding(.horizontal, theme.padding.grid3x)
        }
        .background(theme.color.background)
        .navigationBarTitle("Colours")
    }

    var generalColors: some View {
        VStack{
            ColorHeadingView(title: "General colours", subTitle: "Used for distinguishing content and content areas within an application")
            
            GeneralColorView(colorName: "Primary", generalColor: theme.color.primary, onGeneralColor: theme.color.onPrimary)
            Spacer()

            GeneralColorView(colorName: "Secondary", generalColor: theme.color.secondary, onGeneralColor: theme.color.onSecondary)
            Spacer()

            GeneralColorView(colorName: "Background", generalColor: theme.color.background, onGeneralColor: theme.color.onBackground)
            Spacer()

            GeneralColorView(colorName: "Surface", generalColor: theme.color.surface, onGeneralColor: theme.color.onSurface)
        }
        .padding(.bottom, theme.padding.grid4x)
    }

    var coreColors: some View {
        VStack{
            ColorHeadingView(title: "Core colours", subTitle: "Used to bring context to an app such as indicating user input or success states")
            
            CoreColorView(colorName: "Input/Output", coreColor: theme.color.inputOutput, onCoreColor: theme.color.onInputOutput)
            Spacer()

            CoreColorView(colorName: "Nominal", coreColor: theme.color.nominal, onCoreColor: theme.color.onNominal)
            Spacer()
            
            CoreColorView(colorName: "Advisory", coreColor: theme.color.advisory, onCoreColor: theme.color.onAdvisory)
            Spacer()
            
            CoreColorView(colorName: "Caution", coreColor: theme.color.caution, onCoreColor: theme.color.onCaution)
            Spacer()

            CoreColorView(colorName: "Warning", coreColor: theme.color.warning, onCoreColor: theme.color.onWarning)
        }
        .padding(.bottom, theme.padding.grid4x)
    }

    var graphicsColors: some View {
        VStack{
            ColorHeadingView(title:"Graphics colours", subTitle: "Only to be used for displaying complex data sets such as graphs and diagrams")
            
            HStack{
                ColorDisplayBox(name: "Graphics Red", color: theme.color.graphicsRed, foregroundColor: .flightBlack)
                Spacer()
                ColorDisplayBox(name: "Graphics Yellow", color: theme.color.graphicsYellow, foregroundColor: .flightBlack)
                Spacer()
                ColorDisplayBox(name: "Graphics Green", color: theme.color.graphicsGreen, foregroundColor: .flightBlack)
            }

            Spacer()

            HStack {
                ColorDisplayBox(name: "Graphics Mint", color: theme.color.graphicsMint, foregroundColor: .flightBlack)
                Spacer()
                ColorDisplayBox(name: "Graphics Cyan", color: theme.color.graphicsCyan, foregroundColor: .flightBlack)
                Spacer()
                ColorDisplayBox(name: "Graphics Blue", color: theme.color.graphicsBlue, foregroundColor: .flightBlack)
            }

            Spacer()

            HStack {
                ColorDisplayBox(name: "Graphics Indigo", color: theme.color.graphicsIndigo, foregroundColor: .flightBlack)
                Spacer()
                ColorDisplayBox(name: "Graphics Purple", color: theme.color.graphicsPurple, foregroundColor: .flightBlack)
                Spacer()
                ColorDisplayBox(name: "Graphics Pink", color: theme.color.graphicsPink, foregroundColor: .flightBlack)
            }
        }
        .padding(.bottom, theme.padding.grid4x)
    }
}

struct ColorHeadingView: View {
    @EnvironmentObject var theme: Theme
    
    var title: String
    var subTitle: String
    
    var body: some View {
        VStack{
            Text(title)
                .fontStyle(theme.font.title1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(subTitle)
                .fontStyle(theme.font.caption1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
    }
}

struct GeneralColorView : View {
    
    @EnvironmentObject var theme: Theme

    var colorName: String
    var generalColor: Color
    var onGeneralColor: ColorState

    var body: some View {
        VStack {
            Text("\(colorName) - \(generalColor.hexaRGBA?.uppercased() ?? "")")
                .foregroundColor(onGeneralColor.default)
                .fontStyle(theme.font.subhead)
                .padding(.top, theme.padding.grid1x)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()

            HStack {
                ColorDisplayBox(name: "On \(colorName)", color: onGeneralColor.default, foregroundColor: generalColor)
                ColorDisplayBox(name: "On \(colorName) Focused", color: onGeneralColor.focusedColor, foregroundColor: generalColor)
                ColorDisplayBox(name: "On \(colorName) Disabled", color: onGeneralColor.disabledColor, foregroundColor: generalColor)
            }
        }
        .padding(theme.padding.grid1x)
        .background(generalColor)
    }

}

struct CoreColorView: View {

    @EnvironmentObject var theme: Theme

    var colorName: String
    var coreColor: ColorState
    var onCoreColor: ColorState

    var body: some View {
        HStack {
            HStack {
                ColorDisplayBox(name: colorName, color: coreColor.default, foregroundColor: onCoreColor.default)
                Spacer()
                ColorDisplayBox(name: "\(colorName) Focused", color: coreColor.focusedColor, foregroundColor: onCoreColor.default)
                Spacer()
                ColorDisplayBox(name: "\(colorName) Disabled", color: coreColor.disabledColor, foregroundColor: onCoreColor.default)
            }
            .padding(theme.padding.grid1x)

            Spacer()

            HStack {
                ColorDisplayBox(name: "On \(colorName)", color: onCoreColor.default, foregroundColor: coreColor.default)
                Spacer()
                ColorDisplayBox(name: "On \(colorName) Focused", color: onCoreColor.focusedColor, foregroundColor: coreColor.default)
                Spacer()
                ColorDisplayBox(name: "On \(colorName) Disabled", color: onCoreColor.disabledColor, foregroundColor: coreColor.default)
            }
            .padding(theme.padding.grid1x)
            .background(coreColor.default)
        }
    }

}

struct ColorDisplayBox: View {

    @EnvironmentObject var theme: Theme

    var name: String
    var color: Color
    var foregroundColor: Color

    var body: some View {
        ZStack {
            Rectangle()
                .fill(color)
            Text("\(name) - \(color.hexaRGBA?.uppercased() ?? "")")
                .foregroundColor(foregroundColor)
                .padding(theme.padding.grid1x)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontStyle(theme.font.caption1)
        }
    }

}

struct Colours_Previews: PreviewProvider {
    static var previews: some View {
        Colours()
            .environmentObject(Theme())

    }
}
