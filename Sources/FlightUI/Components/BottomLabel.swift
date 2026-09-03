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
    var accessoryViewContext: AccessoryViewContext<AccessoryView>?

    init(
        _ config: BottomLabelConfig = BottomLabelConfig(),
        accessoryViewContext: AccessoryViewContext<AccessoryView>? = nil
    ) {
        self.config = config
        self.accessoryViewContext = accessoryViewContext
    }

    var body: some View {
        HStack(spacing: 0) {
            if let label = config.label, config.isVisible {
                if let image = getLabelImageSystemName() {
                    Image(systemName: image)
                        .foregroundColor(getLabelColor())
                        .padding(.leading, theme.padding.grid1x)
                    Text(label)
                        .foregroundColor(getLabelColor())
                        .fontStyle(theme.font.caption1)
                        .padding(.leading, theme.padding.grid1x)
                } else {
                    Text(label)
                        .foregroundColor(getLabelColor())
                        .fontStyle(theme.font.caption1)
                        .padding(.leading, theme.padding.grid0_5x)
                }
                Spacer()
            } else if config.isVisible {
                Text("-")
                    .foregroundColor(theme.color.surfaceHigh.opacity(0))
                    .fontStyle(theme.font.caption1)
                Spacer()
            }
            if let accessoryViewContext, accessoryViewContext.isVisible {
                accessoryViewContext.view
            }
        }
    }
    
    private func getLabelImageSystemName() -> String? {
        switch config.state {
        case .default:
            return nil
        case .advisory:
            return nil
        case .nominal:
            return nil
        case .caution:
            return "exclamationmark.circle"
        case .warning:
            return "xmark.circle"
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
        self.accessoryViewContext = nil
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
