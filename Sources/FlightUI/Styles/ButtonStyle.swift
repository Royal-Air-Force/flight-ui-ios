import SwiftUI

public struct FilledButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.isFocused) private var isFocused: Bool
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], theme.padding.grid2x)
            .frame(minHeight: theme.size.medium)
            .foregroundColor(theme.color.onNominal.getColorForState(disabled: !isEnabled, focused: isFocused))
            .background(theme.color.nominal.getColorForState(disabled: !isEnabled, focused: isFocused))
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .fontWeight(.semibold)
            .fontStyle(theme.font.body)
            .clipShape(Capsule())
    }
}

public struct OutlineButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.isFocused) private var isFocused: Bool
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], theme.padding.grid2x)
            .frame(minHeight: theme.size.medium)
            .foregroundColor(theme.color.nominal.getColorForState(disabled: !isEnabled, focused: isFocused))
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .fontWeight(.semibold)
            .fontStyle(theme.font.body)
            .clipShape(Capsule())
            .overlay(
                Capsule(style: .circular)
                    .strokeBorder(theme.color.nominal.getColorForState(disabled: !isEnabled, focused: isFocused), style: StrokeStyle(lineWidth: theme.size.border))
            )
    }
}
