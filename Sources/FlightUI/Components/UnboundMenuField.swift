//
//  UnboundMenuField.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

public struct UnboundMenuField<SelectionType: UnboundSelectionEnum>: View {
    @EnvironmentObject var theme: Theme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.menuFieldStyle) var style: MenuFieldStyle

    @Binding var selection: SelectionType?
    var options: [SelectionType]
    let placeholder: String?
    var topLabel: String?
    var topLabelSpacer: Bool
    var bottomLabelConfig: BottomLabelConfig

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
        VStack(alignment: .leading, spacing: theme.padding.grid0_5x) {
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
                .fontStyle(theme.font.subhead)
        } else if topLabelSpacer {
            Text("-")
                .foregroundColor(theme.color.surfaceHigh.opacity(0))
                .fontStyle(theme.font.subhead)
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
        .padding(.horizontal, theme.padding.grid2x)
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
                .fontStyle(theme.font.bodyBold)
        } else if let placeholderText = placeholder {
            Label(placeholderText, image: "")
                .labelStyle(MenuLabelStyle(textColor: style.getFontColor(theme, isPlaceholder: true, isEnabled: isEnabled)))
                .fontStyle(theme.font.bodyBold)
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

#if DEBUG

private enum UnboundPreviewOptions: UnboundSelectionEnum {
    static var allCases: [UnboundPreviewOptions] {
        return [.defaultSelected, .nominalSelected, .cautionSelected, .warningSelected]
    }

    case customSelected(String)
    case defaultSelected
    case nominalSelected
    case cautionSelected
    case warningSelected

    var description: String {
        switch self {
        case .defaultSelected:
            return "Default Selected"
        case .nominalSelected:
            return "Nominal Selected"
        case .cautionSelected:
            return "Caution Selected"
        case .warningSelected:
            return "Warning Selected"
        case .customSelected(let customString):
            return customString
        }
    }

    static func custom(string: String) -> UnboundPreviewOptions {
        return .customSelected(string)
    }
}

struct UnboundMenuField_Previews: PreviewProvider {
    static var theme: Theme = Theme(baseScheme: .dark)

    static var previews: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid2x) {
            HStack {
                UnboundMenuField(selection: .constant(nil),
                             options: UnboundPreviewOptions.allCases,
                             placeholder: "Default Unbound Menu")
                .menuFieldStyle(.default)
                UnboundMenuField(selection: .constant(UnboundPreviewOptions.defaultSelected),
                             options: UnboundPreviewOptions.allCases,
                             placeholder: "Default Unbound Menu")
                .menuFieldStyle(.default)
                UnboundMenuField(selection: .constant(nil),
                             options: UnboundPreviewOptions.allCases,
                             placeholder: "Default Disabled")
                .menuFieldStyle(.default)
                .disabled(true)
            }
            HStack {
                UnboundMenuField(selection: .constant(nil),
                             options: UnboundPreviewOptions.allCases,
                             placeholder: "Nominal Unbound Menu")
                .menuFieldStyle(.nominal)
                UnboundMenuField(selection: .constant(UnboundPreviewOptions.nominalSelected),
                             options: UnboundPreviewOptions.allCases,
                             placeholder: "Nominal Unbound Menu")
                .menuFieldStyle(.nominal)
                UnboundMenuField(selection: .constant(nil),
                             options: UnboundPreviewOptions.allCases,
                             placeholder: "Nominal Disabled")
                .menuFieldStyle(.nominal)
                .disabled(true)
            }
            HStack {
                UnboundMenuField(selection: .constant(nil),
                             options: UnboundPreviewOptions.allCases,
                             placeholder: "Caution Unbound Menu")
                .menuFieldStyle(.caution)
                UnboundMenuField(selection: .constant(UnboundPreviewOptions.cautionSelected),
                             options: UnboundPreviewOptions.allCases,
                             placeholder: "Caution Unbound Menu")
                .menuFieldStyle(.caution)
                UnboundMenuField(selection: .constant(nil),
                             options: UnboundPreviewOptions.allCases,
                             placeholder: "Caution Disabled")
                .menuFieldStyle(.caution)
                .disabled(true)
            }
            HStack {
                UnboundMenuField(selection: .constant(nil),
                             options: UnboundPreviewOptions.allCases,
                             placeholder: "Warning Unbound Menu")
                .menuFieldStyle(.warning)
                UnboundMenuField(selection: .constant(UnboundPreviewOptions.warningSelected),
                             options: UnboundPreviewOptions.allCases,
                             placeholder: "Warning Unbound Menu")
                .menuFieldStyle(.warning)
                UnboundMenuField(selection: .constant(nil),
                             options: UnboundPreviewOptions.allCases,
                             placeholder: "Warning Disabled")
                .menuFieldStyle(.warning)
                .disabled(true)
            }
            Divider()
            HStack(alignment: .top) {
                UnboundMenuField(selection: .constant(nil),
                             options: UnboundPreviewOptions.allCases,
                             placeholder: "Default Top Label", topLabel: "Top Label")
                .menuFieldStyle(.default)
                UnboundMenuField(selection: .constant(nil),
                             options: UnboundPreviewOptions.allCases,
                             placeholder: "Hidden Top Label", topLabelSpacer: true)
                .menuFieldStyle(.default)
            }
            HStack(alignment: .top) {
                UnboundMenuField(selection: .constant(nil),
                             options: UnboundPreviewOptions.allCases,
                             placeholder: "Support Label", bottomLabelConfig: BottomLabelConfig("Default Label"))
                .menuFieldStyle(.default)
                UnboundMenuField(selection: .constant(nil),
                             options: UnboundPreviewOptions.allCases,
                          placeholder: "Support Label", bottomLabelConfig: BottomLabelConfig("Nominal Label", state: .nominal))
                .menuFieldStyle(.default)
                UnboundMenuField(selection: .constant(nil),
                             options: UnboundPreviewOptions.allCases,
                          placeholder: "Support Label", bottomLabelConfig: BottomLabelConfig("Caution Label", state: .caution))
                .menuFieldStyle(.default)
                UnboundMenuField(selection: .constant(nil),
                             options: UnboundPreviewOptions.allCases,
                          placeholder: "Support Label", bottomLabelConfig: BottomLabelConfig("Warning Label", state: .warning))
                .menuFieldStyle(.default)
            }
        }
        .environmentObject(theme)
        .previewDisplayName("Unbound Menu Field Style")
        .preferredColorScheme(theme.baseScheme)
    }
}

#endif
