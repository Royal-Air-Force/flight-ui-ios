//
//  SupportLabel.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

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

#if DEBUG

struct SupportLabel_Previews: PreviewProvider {
    static var theme: Theme = Theme(baseScheme: .dark)

    static var previews: some View {
        VStack(spacing: theme.padding.grid2x) {
            SupportLabel(SupportLabelConfig("Default Support Label"))
            SupportLabel(SupportLabelConfig("Advisory Support Label", state: .advisory))
            SupportLabel(SupportLabelConfig("Nominal Support Label", state: .nominal))
            SupportLabel(SupportLabelConfig("Caution Support Label", state: .caution))
            SupportLabel(SupportLabelConfig("Warning Support Label", state: .warning))
        }
        .environmentObject(theme)
        .previewDisplayName("Support Label")
        .preferredColorScheme(theme.baseScheme)
    }
}

#endif
