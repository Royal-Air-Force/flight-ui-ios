import SwiftUI

// MARK: - Bottom Label Config

public struct BottomLabelConfig: Sendable {
    public let label: String?
    public let state: InputAlertingState
    public let isVisible: Bool

    public init(
        _ label: String? = nil,
        state: InputAlertingState = .default,
        isVisible: Bool = true
    ) {
        self.label = label
        self.state = state
        self.isVisible = isVisible
    }
}

// MARK: - Bottom Label View

struct BottomLabel: View {
    @Environment(\.theme) var theme

    let config: BottomLabelConfig

    init(_ config: BottomLabelConfig = BottomLabelConfig()) {
        self.config = config
    }

    var body: some View {
        if let label = config.label, config.isVisible {
            Text(label)
                .foregroundColor(labelColor)
                .fontStyle(theme.typography.caption1)
                .padding(.horizontal, theme.spacing.grid2x)
        } else if config.isVisible {
            Text("-")
                .foregroundColor(theme.color.surfaceHigh.opacity(0))
                .fontStyle(theme.typography.caption1)
        }
    }

    private var labelColor: Color {
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
