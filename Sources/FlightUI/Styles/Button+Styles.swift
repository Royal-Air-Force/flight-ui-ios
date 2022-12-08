import SwiftUI

// TODO: Move to Theme
fileprivate let horizontalPadding = 50.0
fileprivate let verticalPadding = 12.0
fileprivate let borderWidth = 3.0

// MARK: - Button Style View -

public struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], horizontalPadding)
            .padding([.top, .bottom], verticalPadding)
            .foregroundColor(Color.neutralBlack)
            .typography(.button)
            .background(isEnabled ? Color.ballisticSecondary : Color.ballisticSecondaryDisabled)
            .clipShape(Capsule())
    }
}

// MARK: - Button Style Extensions -

public extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: Self {
        return .init()
    }
}

public struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    var foregroundColor: Color {
        isEnabled ? Color.ballisticSecondary : Color.ballisticSecondaryDisabled
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], horizontalPadding)
            .padding([.top, .bottom], verticalPadding)
            .foregroundColor(foregroundColor)
            .typography(.button)
            .clipShape(Capsule())
            .overlay(
                Capsule(style: .circular)
                    .strokeBorder(foregroundColor,
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
            .foregroundColor(isEnabled ? Color.ballisticPrimary : Color.neutralLightGray)
            .typography(.button)
    }
}

public extension ButtonStyle where Self == TertiaryButtonStyle {
    static var tertiary: Self {
        return .init()
    }
}

// MARK: - Preview Code -

#if DEBUG

struct Button_Previews: PreviewProvider {
    private static var buttonList: some View {
        VStack(alignment: .leading, spacing: 32.0) {
            Button("Primary", action: {})
                .buttonStyle(.primary)
            
            Button("Primary Disabled", action: {})
                .buttonStyle(.primary)
                .disabled(true)
            
            Button(action: {}, label: {
                HStack {
                    Image(systemName: "pencil")
                    Text("Primary with Icon")
                }
            })
            .buttonStyle(.primary)
            
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
            .previewDisplayName("All Buttons")
            .preferredColorScheme(.dark)
    }
}

#endif
