import SwiftUI

// MARK: - Primary Button Style View -

public struct PrimaryButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], theme.buttonHorizontalPadding)
            .padding([.top, .bottom], theme.buttonVerticalPadding)
            .foregroundColor(theme.primaryButtonForeground)
            .font(theme.typography.body)
            .background(isEnabled ? theme.primaryButtonBackground : theme.primaryButtonBackground.opacity(theme.disabledButtonOpacity))
            .clipShape(Capsule())
    }
}

// MARK: - Primary Button Style Extensions -

public extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: Self {
        return .init()
    }
}

// MARK: - Secondary Button Style View -

public struct SecondaryButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], theme.buttonHorizontalPadding)
            .padding([.top, .bottom], theme.buttonVerticalPadding)
            .foregroundColor(isEnabled ? theme.secondaryButtonForeground : theme.secondaryButtonForeground.opacity(theme.disabledButtonOpacity))
            .font(theme.typography.body)
            .clipShape(Capsule())
            .overlay(
                Capsule(style: .circular)
                    .strokeBorder(isEnabled ? theme.secondaryButtonBackground : theme.secondaryButtonBackground.opacity(theme.disabledButtonOpacity),
                                  style: StrokeStyle(lineWidth: theme.buttonBorderWidth))
            )
    }
}

public struct UpdatedSecondaryButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing])
            .padding([.top, .bottom], theme.buttonVerticalPadding)
            .foregroundColor(isEnabled ? theme.secondaryButtonForeground : theme.secondaryButtonForeground.opacity(theme.disabledButtonOpacity))
            .background(theme.secondaryButtonForeground.opacity(theme.disabledButtonOpacity))
            .font(theme.typography.body)
            .clipShape(Capsule())
    }
}

// MARK: - Secondary Button Style Extensions -

public extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: Self {
        return .init()
    }
}

public extension ButtonStyle where Self == UpdatedSecondaryButtonStyle {
    static var updatedSecondary: Self {
        return .init()
    }
}

// MARK: - Tertiary Button Style View -

public struct TertiaryButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(theme.typography.body)
            .padding([.leading, .trailing], theme.buttonHorizontalPadding)
            .padding([.top, .bottom], theme.buttonVerticalPadding)
            .foregroundColor(isEnabled ? theme.tertiaryButtonColor : theme.tertiaryButtonDisabledColor)
    }
}

// MARK: - Tertiary Button Style Extensions -

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

            VStack(alignment: .leading, spacing: 24) {
                Button("Updated Secondary", action: {})
                    .buttonStyle(.updatedSecondary)

                Button("Updated Secondary Disabled", action: {})
                    .buttonStyle(.updatedSecondary)
                    .disabled(true)

                Button(action: {}, label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Updated Secondary with Icon Disabled")
                    }
                })
                .buttonStyle(.updatedSecondary)

                Button(action: {}, label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Updated Secondary with Icon Disabled")
                    }
                })
                .buttonStyle(.updatedSecondary)
                .disabled(true)
            }

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
            .environmentObject(Theme())
            .previewDisplayName("All Buttons")
            .preferredColorScheme(.dark)

    }
}

#endif
