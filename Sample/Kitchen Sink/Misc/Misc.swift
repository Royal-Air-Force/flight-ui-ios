import SwiftUI
import FlightUI

struct Misc: View {
    @EnvironmentObject var theme: Theme
    
    // Fields (move to FlightUI Theme)
    fileprivate let fieldCornerRadius = 5.0
    fileprivate let mediumFontSize = 40.0
    fileprivate let largeFontSize = 80.0
    
    var body: some View {
        ScrollView {
            VStack {
                expandingPanel
                    .padding([.bottom], theme.padding.grid6x)
                
                nonExpandingPanel
                    .padding([.bottom], theme.padding.grid6x)
                
                bigParameters
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
    
    var bigParameters: some View {
        HStack(spacing: theme.padding.grid3x) {
            VStack(spacing: 0) {
                HStack {
                    Text("x")
                        .font(.system(size: mediumFontSize))
                        .background(theme.color.surface)
                        .cornerRadius(fieldCornerRadius)
                    
                    Spacer()
                }
                
                Text("180")
                    .font(.system(size: largeFontSize))
                    .bold()
                
            }
            .background(theme.color.background)
            .overlay(
                RoundedRectangle(cornerRadius: fieldCornerRadius)
                    .stroke(Color.white, lineWidth: 2)
            )
            VStack(spacing: 0) {
                HStack {
                    Text("y")
                        .font(.system(size: mediumFontSize))
                        .background(theme.color.surface)
                        .cornerRadius(fieldCornerRadius)
                    
                    Spacer()
                }
                
                Text(String(format: "%.2f", 0.02))
                    .font(.system(size: largeFontSize))
                    .bold()
                
            }
            .background(theme.color.background)
            .overlay(
                RoundedRectangle(cornerRadius: fieldCornerRadius)
                    .stroke(Color.white, lineWidth: 2)
            )
            VStack(spacing: 0) {
                HStack {
                    Text("z")
                        .font(.system(size: mediumFontSize))
                        .background(theme.color.background)
                        .cornerRadius(fieldCornerRadius)
                    
                    Spacer()
                }
                
                Text(String(format: "%.1f", 50.0))
                    .font(.system(size: largeFontSize))
                    .bold()
                
            }
            .background(theme.color.background)
            .overlay(
                RoundedRectangle(cornerRadius: fieldCornerRadius)
                    .stroke(Color.white, lineWidth: 2)
            )
            Spacer()
            
        }
    }
    
    
}
