import SwiftUI

// MARK: - Menu Label Style

struct MenuLabelStyle: LabelStyle {
    var textColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .title.foregroundColor(textColor)
    }
}

// MARK: - Menu Field

public struct MenuField<SelectionType: CustomStringConvertible & Hashable>: View {
    @Environment(\.theme) var theme
    @Environment(\.menuFieldStyle) var style
    @Environment(\.isEnabled) private var isEnabled
    @FocusState private var isFocused: Bool

    @Binding var selection: SelectionType?
    let options: [SelectionType]
    let placeholder: String?
    let topLabel: String?
    let topLabelSpacer: Bool
    let bottomLabelConfig: BottomLabelConfig

    public init(
        selection: Binding<SelectionType?>,
        options: [SelectionType],
        placeholder: String? = nil,
        topLabel: String? = nil,
        topLabelSpacer: Bool = false,
        bottomLabelConfig: BottomLabelConfig = .init(isVisible: false)
    ) {
        self._selection = selection
        self.options = options
        self.placeholder = placeholder
        self.topLabel = topLabel
        self.topLabelSpacer = topLabelSpacer
        self.bottomLabelConfig = bottomLabelConfig
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.grid0_5x) {
            buildTopLabel()
            buildMenuField()
            BottomLabel(bottomLabelConfig)
        }
    }

    @ViewBuilder
    private func buildTopLabel() -> some View {
        if let top = topLabel {
            Text(top)
                .foregroundColor(theme.color.primary)
                .fontStyle(theme.typography.subhead)
        } else if topLabelSpacer {
            Text("-")
                .foregroundColor(theme.color.surfaceHigh.opacity(0))
                .fontStyle(theme.typography.subhead)
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
            .padding(.horizontal, theme.spacing.grid2x)
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
                .fontStyle(style.config.fontStyle ?? theme.typography.bodyBold)
        } else if let placeholderText = placeholder {
            Label(placeholderText, image: "")
                .labelStyle(MenuLabelStyle(textColor: style.getFontColor(theme, isPlaceholder: true, isEnabled: isEnabled)))
                .fontStyle(style.config.fontStyle ?? theme.typography.bodyBold)
        }
    }
}
