import SwiftUI
import FlightUI

struct Tab3: View {
    @EnvironmentObject var theme: Theme
    @StateObject private var viewModel = ViewModel()
    
    // Fields (move to FlightUI Theme)
    fileprivate let fieldCornerRadius = 5.0
    fileprivate let mediumFontSize = 40.0
    fileprivate let largeFontSize = 80.0
    
    fileprivate let boxMinHeight: CGFloat = 126
    fileprivate let boxIdealWidth: CGFloat = 194
    
    var body: some View {
        VStack {
            tabHeader
                .padding([.top, .bottom], theme.xxlarge)
            ScrollView {
                colors
                    .padding([.bottom], theme.xxlarge)
                
                
                expandingPanel
                    .padding([.bottom], theme.xxlarge)
                
                nonExpandingPanel
                    .padding([.bottom], theme.xxlarge)
                
                bigParameters
  
            }
        }
        .padding([.leading, .trailing], theme.xxlarge)
        .background(Color.flightBlack)
    }
    
    @ViewBuilder
    var tabHeader: some View {
        HStack {
            Text("Display")
                .typography(.h1)
            Spacer()
        }
    }
    
    var colors: some View {
        VStack {
            coreColours
                .padding([.bottom], theme.xxlarge)
            
            supportingColours
                .padding([.bottom], theme.xxlarge)
            
            warningErrorColours
                .padding([.bottom], theme.xxlarge)

        }
    }
    
    var coreColours: some View {
        VStack{
            HStack {
                Text("Core colours")
                    .typography(.h1)
                Spacer()
            }
            HStack {
                VStack{
                    Rectangle()
                        .fill(Color.flightGreen)
                    HStack{
                        Text("flightGreen")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    
                    HStack{
                        Text("#56BD37")
                            .typography(.caption)
                        Spacer()
                    }
                }
                .frame(minHeight: boxMinHeight)
                .padding([.trailing], theme.xxlarge)
                
                Spacer()
                
                VStack{
                    Rectangle()
                        .fill(Color.flightWhite)
                    HStack{
                        Text("flightWhite")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack{
                        Text("#FFFFFF")
                            .typography(.caption)
                        Spacer()
                    }
                }
                .frame(minHeight: boxMinHeight)
                .padding([.trailing], theme.xxlarge)
            }
        }

    }
    
    var supportingColours: some View {
        VStack{
            HStack {
                Text("Supporting colours")
                    .typography(.h1)
                Spacer()
            }
            HStack {
                VStack{
                    Rectangle()
                        .fill(Color.flightBlack)
                    HStack{
                        Text("flightBlack")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack{
                        Text("#121212")
                            .typography(.caption)
                        Spacer()
                    }
                }
                .frame(minHeight: boxMinHeight)
                .padding([.trailing], theme.xxlarge)
                
                Spacer()
                
                VStack{
                    Rectangle()
                        .fill(Color.flightLightGray)
                    HStack{
                        Text("flightDarkGray")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack{
                        Text("#2C2C2C")
                            .typography(.caption)
                        Spacer()
                    }
                }
                .frame(minHeight: boxMinHeight)
                .padding([.trailing], theme.xxlarge)
               
            }
            .padding([.bottom], theme.medium)
            
            HStack{
                VStack{
                    Rectangle()
                        .fill(Color.flightDarkGray)
                    HStack{
                        Text("flightLightGray")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    
                    HStack{
                        Text("#ACACAC")
                            .typography(.caption)
                        Spacer()
                    }
                }
                .frame(minHeight: boxMinHeight)
                .padding([.trailing], theme.xxlarge)
                
                VStack{
                    Rectangle()
                        .fill(Color.flightBlue)

                    HStack{
                        Text("flightBlue")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    HStack{
                        Text("#5EB3F1")
                            .typography(.caption)
                        Spacer()
                    }
                }
                .frame(minHeight: boxMinHeight)
                .padding([.trailing], theme.xxlarge)
            }
            
            
        }
    }
    
    var warningErrorColours: some View {
        VStack{
            HStack {
                Text("Warning and error colours")
                    .typography(.h1)
                Spacer()
            }
            HStack{
                VStack{
                    Rectangle()
                        .fill(Color.flightYellow)  // Q - should we expxand ShapeStyle?
                    HStack{
                        Text("warning")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    
                    HStack{
                        Text("#FCF150")
                            .typography(.caption)
                        Spacer()
                    }
                }
                .frame(minHeight: boxMinHeight)
                .padding([.trailing], theme.xxlarge)
                
                Spacer()
                
                VStack{
                    Rectangle()
                        .fill(Color.flightOrange)   // This is wrong
                    HStack{
                        Text("error")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack{
                        Text("#EA3323")
                            .typography(.caption)
                        Spacer()
                    }
                }
                .frame(minHeight: boxMinHeight)
                .padding([.trailing], theme.xxlarge)
            }
            
        }
    }
    

    var expandingPanel: some View {
        Panel(title: "Expandable Panel", options: .expandable(expanded: true)) {
            VStack {
                HStack(alignment: .top) {
                   Text("Lots of lovely panel content")
                    Spacer()
                }
            }
            .padding(theme.xxlarge)
        }
    }
    
    var nonExpandingPanel: some View {
        Panel(title: "Expandable Panel", typography: (.h1)) {
            VStack {
                HStack(alignment: .top) {
                   Text("Lots of lovely panel content")
                    Spacer()
                }
            }
            .padding(theme.xxlarge)
        }
    }
    
    var bigParameters: some View {
        HStack(spacing: theme.large) {
            VStack(spacing: 0) {
                HStack {
                    Text("x")
                        .font(.system(size: mediumFontSize))
                        .background(Color.flightLightGray)
                        .cornerRadius(fieldCornerRadius)
                    
                    Spacer()
                }
                
                Text("180")
                    .font(.system(size: largeFontSize))
                    .bold()
                
            }
            .background(Color.flightDarkGray)
            .overlay(
                RoundedRectangle(cornerRadius: fieldCornerRadius)
                    .stroke(Color.white, lineWidth: 2)
            )
            VStack(spacing: 0) {
                HStack {
                    Text("y")
                        .font(.system(size: mediumFontSize))
                        .background(Color.flightLightGray)
                        .cornerRadius(fieldCornerRadius)
                    
                    Spacer()
                }
                
                Text(String(format: "%.2f", 0.02))
                    .font(.system(size: largeFontSize))
                    .bold()
                
            }
            .background(Color.flightDarkGray)
            .overlay(
                RoundedRectangle(cornerRadius: fieldCornerRadius)
                    .stroke(Color.white, lineWidth: 2)
            )
            VStack(spacing: 0) {
                HStack {
                    Text("z")
                        .font(.system(size: mediumFontSize))
                        .background(Color.flightLightGray)
                        .cornerRadius(fieldCornerRadius)
                    
                    Spacer()
                }
                
                Text(String(format: "%.1f", 50.0))
                    .font(.system(size: largeFontSize))
                    .bold()
                
            }
            .background(Color.flightDarkGray)
            .overlay(
                RoundedRectangle(cornerRadius: fieldCornerRadius)
                    .stroke(Color.white, lineWidth: 2)
            )
            Spacer()
            
        }
    }
}



struct Tab3_Previews: PreviewProvider {
    static var previews: some View {
        Tab3()
            .environmentObject(Theme())
    }
}
