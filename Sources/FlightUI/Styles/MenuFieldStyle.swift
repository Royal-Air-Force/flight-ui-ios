import SwiftUI

internal class MenuFieldDefaults {
    static let disabledOpacity: CGFloat = 0.38
    static let stateBackgroundOpacity: CGFloat = 0.08
    static let hintOpacity: CGFloat = 0.54
}

public struct MenuFieldStyle {
    var state: InputFieldState
    var config: InputFieldConfig

    public init(state: InputFieldState, config: InputFieldConfig = InputFieldConfig()) {
        self.state = state
        self.config = config
    }
}

public struct MenuFieldStyleEnvironmentKey: EnvironmentKey {
    public static var defaultValue: MenuFieldStyle = .init(
        state: .default, config: .init()
    )
}

extension EnvironmentValues {
    var menuFieldStyle: MenuFieldStyle {
        get { self[MenuFieldStyleEnvironmentKey.self] }
        set { self[MenuFieldStyleEnvironmentKey.self] = newValue }
    }
}

extension View {
    public func menuFieldStyle(_ style: MenuFieldStyle) -> some View {
        environment(\.menuFieldStyle, style)
    }
}
