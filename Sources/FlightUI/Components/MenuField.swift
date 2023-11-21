import SwiftUI

public struct MenuLabelStyle: LabelStyle {
    var textColor: Color

    init(textColor: Color) {
        self.textColor = textColor
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .title.foregroundColor(textColor)
    }
}

public struct UnboundMenuField<SelectionType: UnboundSelectionEnum>: View {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.menuFieldStyle) var style: MenuFieldStyle

    @Binding var selection: SelectionType?
    var options: [SelectionType]
    let placeholder: String?

    @State private var isSheetShown = false
    @State private var queryString = ""

    var searchResults: [SelectionType] {
        if queryString.isEmpty {
            return options
        } else {
            return options.filter { $0.description.contains(queryString) }
        }
    }

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
        HStack {
            if let selectedItem = selection?.description {
                Label(selectedItem, image: "")
                    .labelStyle(MenuLabelStyle(textColor: getFontColor(isPlaceholder: false)))
                    .fontStyle(theme.font.bodyBold)
            } else if let placeholderText = placeholder {
                Label(placeholderText, image: "")
                    .labelStyle(MenuLabelStyle(textColor: getFontColor(isPlaceholder: true)))
                    .fontStyle(theme.font.bodyBold)
            }
            Spacer()
            Image(systemName: "chevron.down")
                .foregroundColor(getFontColor(isPlaceholder: false))
                .fontWeight(.bold)
        }
        .sheet(isPresented: $isSheetShown) {
            VStack {
                NavigationStack {
                    List {
                        ForEach(searchResults, id: \.description) { item in
                            HStack {
                                Text(item.description)
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .listRowBackground(theme.color.surfaceHigh)
                            .onTapGesture {
                                onSelected(item: item)
                            }
                        }
                        if !queryString.isEmpty && (options.filter { $0.description == queryString }.isEmpty) {
                            HStack {
                                Text(queryString)
                                Spacer()
                                Image(systemName: "plus")
                            }
                            .contentShape(Rectangle())
                            .listRowBackground(theme.color.surfaceHigh)
                            .onTapGesture {
                                onSelected(item: SelectionType.custom(string: queryString))
                            }
                        }
                    }
                    .environment(\.defaultMinListRowHeight, theme.size.large)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                isSheetShown = false
                            } label: {
                                HStack {
                                    Image(systemName: "xmark")
                                    Text("Close")
                                }
                                .foregroundColor(theme.color.primary)
                            }
                        }
                    }
                    .toolbarBackground(theme.color.surfaceLow, for: .navigationBar)
                    .scrollContentBackground(.hidden)
                    .background(theme.color.surfaceLow)
                }
                .searchable(text: $queryString, placement: .navigationBarDrawer(displayMode: .always), prompt: placeholder ?? "Search")
                .onSubmit(of: .search) {
                    onSelected(item: SelectionType.custom(string: queryString))
                }
                .accentColor(theme.color.primary)
            }
            .interactiveDismissDisabled()
        }
        .padding(.horizontal, theme.padding.grid2x)
        .frame(height: theme.size.large)
        .background(getFieldBackgroundColor())
        .cornerRadius(getCornerRadius())
        .overlay {
            RoundedRectangle(cornerRadius: getCornerRadius(), style: .continuous)
                .strokeBorder(getFieldBorderColor(), lineWidth: getFieldBorderSize())
        }
        .onTapGesture {
            isSheetShown = true
        }
    }

    private func onSelected(item: SelectionType) {
        selection = item
        isSheetShown = false
        queryString = ""
    }

    private func getFontColor(isPlaceholder: Bool) -> Color {
        if isPlaceholder {
            return theme.color.primary.opacity(MenuFieldDefaults.hintOpacity)
        } else if let overrideColor = style.config.fontColor {
            return overrideColor.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        } else {
            return theme.color.inputOutput.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        }
    }

    private func getFieldBackgroundColor() -> Color {
        if !isEnabled {
            return theme.color.surfaceHigh.opacity(MenuFieldDefaults.disabledOpacity)
        }

        if let overrideColor = style.config.backgroundColor {
            return overrideColor
        }

        switch style.state {
        case .nominal:
            return theme.color.nominal.opacity(MenuFieldDefaults.stateBackgroundOpacity)
        case .caution:
            return theme.color.caution.opacity(MenuFieldDefaults.stateBackgroundOpacity)
        case .warning:
            return theme.color.warning.opacity(MenuFieldDefaults.stateBackgroundOpacity)
        default:
            return theme.color.surfaceHigh
        }
    }

    private func getCornerRadius() -> CGFloat {
        if let overrideRadius = style.config.cornerRadius {
            return overrideRadius
        }
        return theme.radius.medium
    }

    private func getFieldBorderColor() -> Color {
        if let overrideColor = style.config.borderColor {
            return overrideColor
        }

        switch style.state {
        case .default:
            return theme.color.surfaceHigh
        case .advisory:
            return theme.color.primary.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        case .nominal:
            return theme.color.nominal.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        case .caution:
            return theme.color.caution.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        case .warning:
            return theme.color.warning.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        }
    }

    private func getFieldBorderSize() -> CGFloat {
        switch style.state {
        case .nominal, .caution, .warning:
            return theme.size.border
        default:
            return 0
        }
    }

}

public struct NewMenuField<SelectionType: CustomStringConvertible & Hashable>: View {
    @EnvironmentObject var theme: Theme
    @Environment(\.menuFieldStyle) var style: MenuFieldStyle
    @Environment(\.isEnabled) private var isEnabled: Bool
    @FocusState private var isFocused: Bool

    @State var customItem: String = ""

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
                if let selectedItem = selection?.description {
                    Label(selectedItem, image: "")
                        .labelStyle(MenuLabelStyle(textColor: getFontColor(isPlaceholder: false)))
                        .fontStyle(style.config.fontStyle ?? theme.font.bodyBold)
                } else if let placeholderText = placeholder {
                    Label(placeholderText, image: "")
                        .labelStyle(MenuLabelStyle(textColor: getFontColor(isPlaceholder: true)))
                        .fontStyle(style.config.fontStyle ?? theme.font.bodyBold)
                }
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(getFontColor(isPlaceholder: false))
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
        .background(getFieldBackgroundColor())
        .cornerRadius(getCornerRadius())
        .overlay {
            RoundedRectangle(cornerRadius: getCornerRadius(), style: .continuous)
                .strokeBorder(getFieldBorderColor(), lineWidth: getFieldBorderSize())
        }
    }

    private func getFontColor(isPlaceholder: Bool) -> Color {
        if isPlaceholder {
            return theme.color.primary.opacity(MenuFieldDefaults.hintOpacity)
        } else if let overrideColor = style.config.fontColor {
            return overrideColor.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        } else {
            return theme.color.inputOutput.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        }
    }

    private func getFieldBackgroundColor() -> Color {
        if !isEnabled {
            return theme.color.surfaceHigh.opacity(MenuFieldDefaults.disabledOpacity)
        }

        if let overrideColor = style.config.backgroundColor {
            return overrideColor
        }

        switch style.state {
        case .nominal:
            return theme.color.nominal.opacity(MenuFieldDefaults.stateBackgroundOpacity)
        case .caution:
            return theme.color.caution.opacity(MenuFieldDefaults.stateBackgroundOpacity)
        case .warning:
            return theme.color.warning.opacity(MenuFieldDefaults.stateBackgroundOpacity)
        default:
            return theme.color.surfaceHigh
        }
    }

    private func getCornerRadius() -> CGFloat {
        if let overrideRadius = style.config.cornerRadius {
            return overrideRadius
        }
        return theme.radius.medium
    }

    private func getFieldBorderColor() -> Color {
        if let overrideColor = style.config.borderColor {
            return overrideColor
        }

        switch style.state {
        case .default:
            return theme.color.surfaceHigh
        case .advisory:
            return theme.color.primary.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        case .nominal:
            return theme.color.nominal.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        case .caution:
            return theme.color.caution.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        case .warning:
            return theme.color.warning.opacity(isEnabled ? 1 : MenuFieldDefaults.disabledOpacity)
        }
    }

    private func getFieldBorderSize() -> CGFloat {
        switch style.state {
        case .nominal, .caution, .warning:
            return theme.size.border
        default:
            return 0
        }
    }
}

public struct OptionalMenuField<SelectionType: CustomStringConvertible & Hashable>: View {
    @EnvironmentObject var theme: Theme
    @Binding var selection: SelectionType?
    var options: [SelectionType]
    let placeholder: String

    public init(selection: Binding<SelectionType?>,
                options: [SelectionType],
                placeholder: String = "Select") {
        self._selection = selection
        self.options = options
        self.placeholder = placeholder
    }

    public var body: some View {
        Menu {
            Picker("", selection: $selection) {
                ForEach(options, id: \.self) { item in
                    Text("\(item.description)").tag(Optional(item))
                }
            }
        } label: {
            HStack {
                Text(selection?.description ?? placeholder)
                    .fontStyle(theme.font.body)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(theme.menuFieldAccent)
                    .fontWeight(.bold)

            }
        }
        .padding()
        .background(theme.menuFieldBackground)
        .frame(height: theme.menuFieldHeight)
        .cornerRadius(theme.menuFieldCornerRadius)
    }
}

public struct MenuField<SelectionType: CustomStringConvertible & Hashable>: View {

    @Environment (\.validationContext) var context
    @EnvironmentObject var theme: Theme
    @Binding var selection: SelectionType
    var options: [SelectionType]

    public init(selection: Binding<SelectionType>,
                options: [SelectionType]) {
        self._selection = selection
        self.options = options
    }

    public var body: some View {
        Menu {
            Picker("", selection: $selection) {
                ForEach(options, id: \.self) { item in
                    Text("\(item.description)").tag(item)
                }
            }
        } label: {
            HStack {
                Text(selection.description)
                    .fontStyle(theme.font.body)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(theme.menuFieldAccent)
                    .fontWeight(.bold)

            }
        }
        .padding()
        .background(theme.menuFieldBackground)
        .frame(height: theme.menuFieldHeight)
        .cornerRadius(theme.menuFieldCornerRadius)
        .overlay {
            if context.status != .valid {
                RoundedRectangle(cornerRadius: theme.radius.medium)
                    .strokeBorder(overlayColor, lineWidth: theme.staticTextFieldBorderWidth)
            }
        }
    }

    private var overlayColor: Color {
        switch context.status {
        case .valid:
            return theme.validationStatusValid
        case .warning:
            return theme.validationStatusWarning
        case .caution:
            return theme.validationStatusCaution
        case .advisory:
            return theme.validationStatusAdvisory
        }
    }
}

struct MenuField_Previews: PreviewProvider {
    @State static var optionalSelection: String?
    @State static var selection: String = "Iron Man"
    static func fakeValidator(value: String, mode: ValidationMode) -> ValidationStatus { return .caution(message: "") }
    @State private static var validationStatus: ValidationStatus = .warning(message: "")
    static let options = ["Thor", "Iron Man", "Captain America"]

    static var previews: some View {

        VStack {
            OptionalMenuField(selection: $optionalSelection,
                      options: options)

            OptionalMenuField(selection: $optionalSelection,
                      options: options,
                      placeholder: "Custom Placeholder Text")
            MenuField(selection: $selection, options: options)
            MenuField(selection: $selection, options: options)
                .validated(by: fakeValidator, status: $validationStatus)
        }
        .padding()
        .environmentObject(Theme())
    }
}
