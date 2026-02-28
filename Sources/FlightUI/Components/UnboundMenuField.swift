import SwiftUI

// MARK: - Unbound Menu Field

public struct UnboundMenuField<SelectionType: UnboundSelectionEnum>: View {
    @Environment(\.theme) var theme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.menuFieldStyle) var style

    @Binding var selection: SelectionType?
    let options: [SelectionType]
    let placeholder: String?
    let topLabel: String?
    let topLabelSpacer: Bool
    let bottomLabelConfig: BottomLabelConfig

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
                .onTapGesture {
                    isSheetShown = true
                }
            BottomLabel(bottomLabelConfig)
        }
    }

    private func onSelected(item: SelectionType) {
        selection = item
        onDismiss()
    }

    private func onDismiss() {
        isSheetShown = false
        queryString = ""
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
        HStack {
            buildLabelText()
            Spacer()
            Image(systemName: "chevron.down")
                .foregroundColor(style.getFontColor(theme, isPlaceholder: false, isEnabled: isEnabled))
                .fontWeight(.bold)
        }
        .sheet(isPresented: $isSheetShown) {
            VStack {
                NavigationStack {
                    List {
                        ForEach(searchResults, id: \.description) { item in
                            buildSearchResult(item: item)
                        }
                        if !queryString.isEmpty && (options.filter { $0.description == queryString }.isEmpty) {
                            buildCustomOption()
                        }
                    }
                    .environment(\.defaultMinListRowHeight, theme.size.large)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                isSheetShown = false
                            } label: {
                                Text("Close")
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
        .padding(.horizontal, theme.spacing.grid2x)
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
                .fontStyle(theme.typography.bodyBold)
        } else if let placeholderText = placeholder {
            Label(placeholderText, image: "")
                .labelStyle(MenuLabelStyle(textColor: style.getFontColor(theme, isPlaceholder: true, isEnabled: isEnabled)))
                .fontStyle(theme.typography.bodyBold)
        }
    }

    @ViewBuilder
    private func buildSearchResult(item: SelectionType) -> some View {
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

    @ViewBuilder
    private func buildCustomOption() -> some View {
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
