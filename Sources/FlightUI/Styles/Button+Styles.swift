import SwiftUI

// MARK: - Button Style View -

public struct PrimaryButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], theme.buttonHorizontalPadding)
            .padding([.top, .bottom], theme.buttonVerticalPadding)
            .foregroundColor(theme.primaryButtonForeground)
            .typography(.button)
            .background(isEnabled ? theme.primaryButtonBackground : theme.primaryButtonBackground.opacity(0.38))
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
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], theme.buttonHorizontalPadding)
            .padding([.top, .bottom], theme.buttonVerticalPadding)
            .foregroundColor(isEnabled ? theme.secondaryButtonForeground : theme.secondaryButtonForeground.opacity(0.38))
            .typography(.button)
            .clipShape(Capsule())
            .overlay(
                Capsule(style: .circular)
                    .strokeBorder(isEnabled ? theme.secondaryButtonBackground : theme.secondaryButtonBackground.opacity(0.38),
                                  style: StrokeStyle(lineWidth: theme.buttonBorderWidth))
            )
    }
}

public extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: Self {
        return .init()
    }
}


public struct TertiaryButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], theme.buttonHorizontalPadding)
            .padding([.top, .bottom], theme.buttonVerticalPadding)
            .foregroundColor(isEnabled ? theme.tertiaryButtonColor : theme.tertiaryButtonDisabledColor)
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
        .environmentObject(Theme())
    }
    
    static var previews: some View {
        buttonList
            .previewDisplayName("All Buttons")
            .preferredColorScheme(.dark)
    }
}

#endif
