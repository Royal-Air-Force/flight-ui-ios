import SwiftUI

public struct MenuField<SelectionType: CustomStringConvertible & Hashable>: View {
    @EnvironmentObject var theme: Theme
    @Environment(\.menuFieldStyle) var style: MenuFieldStyle
    @Environment(\.isEnabled) private var isEnabled: Bool
    @FocusState private var isFocused: Bool

    @Binding var selection: SelectionType?
    var options: [SelectionType]
    var placeholder: String?
    var topLabel: String?
    var topLabelSpacer: Bool
    var supportLabelConfig: SupportLabelConfig

    public init(
        selection: Binding<SelectionType?>,
        options: [SelectionType],
        placeholder: String? = nil,
        topLabel: String? = nil,
        topLabelSpacer: Bool = false,
        supportLabelConfig: SupportLabelConfig = .init(isVisible: false)
    ) {
        self._selection = selection
        self.options = options
        self.placeholder = placeholder
        self.topLabel = topLabel
        self.topLabelSpacer = topLabelSpacer
        self.supportLabelConfig = supportLabelConfig
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid0_5x) {
            buildTopLabel()
            buildMenuField()
            SupportLabel(supportLabelConfig)
        }
    }

    @ViewBuilder
    private func buildTopLabel() -> some View {
        if let top = topLabel {
            Text(top)
                .foregroundColor(theme.color.primary)
                .fontStyle(theme.font.subhead)
        } else if topLabelSpacer {
            Text("-")
                .foregroundColor(theme.color.surfaceHigh.opacity(0))
                .fontStyle(theme.font.subhead)
        }
    }

    @ViewBuilder
    private func buildMenuField() -> some View {
        Menu {
            Picker("", selection: $selection) {
                ForEach(options, id: \.self) { item in
                    Text(item.description).tag(Optional(item))
                }
            }
        } label: {
            HStack {
                buildLabelText()
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(style.getFontColor(theme, isPlaceholder: false, isEnabled: isEnabled))
                    .fontWeight(.bold)
            }
            .padding(.horizontal, theme.padding.grid2x)
            .frame(height: theme.size.large)
            .focused($isFocused)
            .onTapGesture {
                isFocused = true
            }
        }
        .frame(height: theme.size.large)
        .background(style.getFieldBackgroundColor(theme, isEnabled: isEnabled))
        .cornerRadius(style.getCornerRadius(theme))
        .overlay {
            RoundedRectangle(cornerRadius: style.getCornerRadius(theme), style: .continuous)
                .strokeBorder(style.getFieldBorderColor(theme, isEnabled: isEnabled), lineWidth: style.getFieldBorderSize(theme))
        }
    }

    @ViewBuilder
    private func buildLabelText() -> some View {
        if let selectedItem = selection?.description {
            Label(selectedItem, image: "")
                .labelStyle(MenuLabelStyle(textColor: style.getFontColor(theme, isPlaceholder: false, isEnabled: isEnabled)))
                .fontStyle(style.config.fontStyle ?? theme.font.bodyBold)
        } else if let placeholderText = placeholder {
            Label(placeholderText, image: "")
                .labelStyle(MenuLabelStyle(textColor: style.getFontColor(theme, isPlaceholder: true, isEnabled: isEnabled)))
                .fontStyle(style.config.fontStyle ?? theme.font.bodyBold)
        }
    }
}
