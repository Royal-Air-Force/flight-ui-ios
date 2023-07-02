import SwiftUI

public struct FilledButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.isFocused) private var isFocused: Bool
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        let bgColor = theme.color.nominal.getColorForState(disabled: !isEnabled, focused: isFocused)
        
        configuration.label
            .padding([.leading, .trailing], theme.padding.grid2x)
            .frame(minHeight: theme.size.medium)
            .foregroundColor(theme.color.onNominal.getColorForState(disabled: !isEnabled, focused: isFocused))
            .background(configuration.isPressed ? bgColor.opacity(0.8) : bgColor)
            .fontWeight(.semibold)
            .fontStyle(theme.font.body)
            .clipShape(Capsule())
    }
}

private extension ColorState {
    func getColorForState(disabled: Bool, focused: Bool) -> Color {
        if (disabled) {
            return self.disabledColor
        } else if (focused) {
            return self.focusedColor
        } else {
            return self.default
        }
    }
}
