import SwiftUI

public struct MenuField<SelectionType: CustomStringConvertible & Hashable>: View {
    @EnvironmentObject var theme: Theme
    @Environment(\.menuFieldStyle) var style: MenuFieldStyle
    @Environment(\.isEnabled) private var isEnabled: Bool
    @FocusState private var isFocused: Bool

    @Binding var selection: SelectionType?
    var options: [SelectionType]
    let placeholder: String?

    public init(
        selection: Binding<SelectionType?>,
        options: [SelectionType],
        placeholder: String? = nil
    ) {
        self._selection = selection
        self.options = options
        self.placeholder = placeholder
    }

    public var body: some View {
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
