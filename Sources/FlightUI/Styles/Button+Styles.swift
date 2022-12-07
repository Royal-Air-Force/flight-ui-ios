import SwiftUI

fileprivate let horizontalPadding = 50.0
fileprivate let verticalPadding = 12.0
fileprivate let borderWidth = 3.0

public struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], horizontalPadding)
            .padding([.top, .bottom], verticalPadding)
            .font(.title2.bold())
            .foregroundColor(Color.neutralBlack)
            .background(isEnabled ? Color.ballisticSecondary : Color.ballisticSecondary.opacity(0.5))
            .clipShape(Capsule())
    }
}

public extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: Self {
        return .init()
    }
}

public struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], horizontalPadding)
            .padding([.top, .bottom], verticalPadding)
            .font(.title2.bold())
            .foregroundColor(isEnabled ? Color.ballisticSecondary : Color.ballisticSecondary.opacity(0.5))
            .clipShape(Capsule())
            .overlay(
                Capsule(style: .circular)
                    .strokeBorder(isEnabled ? Color.ballisticSecondary : Color.ballisticSecondary.opacity(0.5),
                                  style: StrokeStyle(lineWidth: borderWidth))
            )
    }
}

public extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: Self {
        return .init()
    }
}


public struct TertiaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], horizontalPadding)
            .padding([.top, .bottom], verticalPadding)
            .font(.title2.bold())
            .foregroundColor(isEnabled ? Color.ballisticPrimary : Color.ballisticPrimary.opacity(0.5))
    }
}

public extension ButtonStyle where Self == TertiaryButtonStyle {
    static var tertiary: Self {
        return .init()
    }
}


struct Button_Previews: PreviewProvider {
    private static var buttonList: some View {
        VStack {
            Button("Primary", action: {})
                .buttonStyle(.primary)
            
            Button(action: {}, label: {
                HStack {
                    Image(systemName: "pencil")
                    Text("Primary with Icon")
                }
            })
            .buttonStyle(.primary)
            
            Button("Primary Disabled", action: {})
                .buttonStyle(.primary)
                .disabled(true)
            
            Button(action: {}, label: {
                HStack {
                    Image(systemName: "pencil")
                    Text("Primary with Icon Disabled")
                }
            })
            .buttonStyle(.primary)
            .disabled(true)
            
            Button("Secondary", action: {})
                .buttonStyle(.secondary)
            
            Button("Secondary Disabled", action: {})
                .buttonStyle(.secondary)
                .disabled(true)
            
            Button("Tertiary", action: {})
                .buttonStyle(.tertiary)
            
            Button("Tertiary Disabled", action: {})
                .buttonStyle(.tertiary)
                .disabled(true)
        }
    }
    
    static var previews: some View {
        buttonList
            .previewDisplayName("All Buttons (Dark)")
            .preferredColorScheme(.dark)
        
        buttonList
            .previewDisplayName("All Buttons (Light)")
            .preferredColorScheme(.light)
    }
}
