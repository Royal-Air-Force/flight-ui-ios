//
//  SupportLabel.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

public struct BottomLabelConfig {
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

struct BottomLabel<AccessoryView: View>: View {
    @EnvironmentObject var theme: Theme
    var config: BottomLabelConfig
    var accessoryView: (()->AccessoryView)?

    init(_ config: BottomLabelConfig = BottomLabelConfig(), accessoryView: (()->AccessoryView)? = nil) {
        self.config = config
        self.accessoryView = accessoryView
    }

    var body: some View {
        HStack {
            if let label = config.label, config.isVisible {
                Text(label)
                    .foregroundColor(getLabelColor())
                    .fontStyle(theme.font.caption1)
                    .padding(.horizontal, theme.padding.grid2x)
                if let accessoryView {
                    Spacer()
                    accessoryView()
                }
            } else if config.isVisible {
                Text("-")
                    .foregroundColor(theme.color.surfaceHigh.opacity(0))
                    .fontStyle(theme.font.caption1)
                if let accessoryView {
                    Spacer()
                    accessoryView()
                }
            }
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

extension BottomLabel where AccessoryView == EmptyView {
    init(_ config: BottomLabelConfig = BottomLabelConfig()) {
        self.config = config
        self.accessoryView = nil
    }
}

#if DEBUG

struct SupportLabel_Previews: PreviewProvider {
    static var theme: Theme = Theme(baseScheme: .dark)

    static var previews: some View {
        VStack(spacing: theme.padding.grid2x) {
            BottomLabel(BottomLabelConfig("Default Support Label"))
            BottomLabel(BottomLabelConfig("Advisory Support Label", state: .advisory))
            BottomLabel(BottomLabelConfig("Nominal Support Label", state: .nominal))
            BottomLabel(BottomLabelConfig("Caution Support Label", state: .caution))
            BottomLabel(BottomLabelConfig("Warning Support Label", state: .warning))
        }
        .environmentObject(theme)
        .previewDisplayName("Support Label")
        .preferredColorScheme(theme.baseScheme)
    }
}

#endif
