import SwiftUI

public struct SupportLabelConfig {
    var label: String?
    var state: InputAlertingState
    var isVisible: Bool

    public init(_ label: String? = nil,
         state: InputAlertingState = .default,
         isVisible: Bool = true
    ) {
        self.label = label
        self.state = state
        self.isVisible = isVisible
    }
}

struct SupportLabel: View {
    @EnvironmentObject var theme: Theme
    var config: SupportLabelConfig

    init(_ config: SupportLabelConfig = SupportLabelConfig()) {
        self.config = config
    }

    var body: some View {
        if let label = config.label, config.isVisible {
            Text(label)
                .foregroundColor(getLabelColor())
                .fontStyle(theme.font.caption1)
                .padding(.horizontal, theme.padding.grid2x)
        } else if config.isVisible {
            Text("-")
                .foregroundColor(theme.color.surfaceHigh.opacity(0))
                .fontStyle(theme.font.caption1)
        }
    }

    private func getLabelColor() -> Color {
        switch config.state {
        case .nominal:
            return theme.color.nominal
        case .caution:
            return theme.color.caution
        case .warning:
            return theme.color.warning
        default:
            return theme.color.secondary
        }
    }

}
