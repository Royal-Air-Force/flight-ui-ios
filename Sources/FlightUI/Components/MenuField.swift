//
//  MenuField.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

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

#if DEBUG

private enum PreviewOptions: String, CaseIterable, CustomStringConvertible {
    case defaultSelected = "Default Selected"
    case nominalSelected = "Nominal Selected"
    case cautionSelected = "Caution Selected"
    case warningSelected = "Warning Selected"

    var description: String {
        return rawValue
    }
}

struct MenuField_Previews: PreviewProvider {
    static var theme: Theme = Theme(baseScheme: .dark)

    static var previews: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid2x) {
            HStack {
                MenuField(selection: .constant(nil),
                             options: PreviewOptions.allCases,
                             placeholder: "Default Menu Field")
                .menuFieldStyle(.default)
                MenuField(selection: .constant(PreviewOptions.defaultSelected),
                             options: PreviewOptions.allCases,
                             placeholder: "Default Menu Field")
                .menuFieldStyle(.default)
                MenuField(selection: .constant(nil),
                             options: PreviewOptions.allCases,
                             placeholder: "Default Disabled")
                .menuFieldStyle(.default)
                .disabled(true)
            }
            HStack {
                MenuField(selection: .constant(nil),
                             options: PreviewOptions.allCases,
                             placeholder: "Nominal Menu Field")
                .menuFieldStyle(.nominal)
                MenuField(selection: .constant(PreviewOptions.nominalSelected),
                             options: PreviewOptions.allCases,
                             placeholder: "Nominal Menu Field")
                .menuFieldStyle(.nominal)
                MenuField(selection: .constant(nil),
                             options: PreviewOptions.allCases,
                             placeholder: "Nominal Disabled")
                .menuFieldStyle(.nominal)
                .disabled(true)
            }
            HStack {
                MenuField(selection: .constant(nil),
                             options: PreviewOptions.allCases,
                             placeholder: "Caution Menu Field")
                .menuFieldStyle(.caution)
                MenuField(selection: .constant(PreviewOptions.cautionSelected),
                             options: PreviewOptions.allCases,
                             placeholder: "Caution Menu Field")
                .menuFieldStyle(.caution)
                MenuField(selection: .constant(nil),
                             options: PreviewOptions.allCases,
                             placeholder: "Caution Disabled")
                .menuFieldStyle(.caution)
                .disabled(true)
            }
            HStack {
                MenuField(selection: .constant(nil),
                             options: PreviewOptions.allCases,
                             placeholder: "Warning Menu Field")
                .menuFieldStyle(.warning)
                MenuField(selection: .constant(PreviewOptions.warningSelected),
                             options: PreviewOptions.allCases,
                             placeholder: "Warning Menu Field")
                .menuFieldStyle(.warning)
                MenuField(selection: .constant(nil),
                             options: PreviewOptions.allCases,
                             placeholder: "Warning Disabled")
                .menuFieldStyle(.warning)
                .disabled(true)
            }
            Divider()
            HStack(alignment: .top) {
                MenuField(selection: .constant(nil),
                             options: PreviewOptions.allCases,
                             placeholder: "Default Top Label", topLabel: "Top Label")
                .menuFieldStyle(.default)
                MenuField(selection: .constant(nil),
                             options: PreviewOptions.allCases,
                             placeholder: "Hidden Top Label", topLabelSpacer: true)
                .menuFieldStyle(.default)
            }
            HStack(alignment: .top) {
                MenuField(selection: .constant(nil),
                             options: PreviewOptions.allCases,
                             placeholder: "Support Label", supportLabelConfig: SupportLabelConfig("Default Label"))
                .menuFieldStyle(.default)
                MenuField(selection: .constant(nil),
                             options: PreviewOptions.allCases,
                          placeholder: "Support Label", supportLabelConfig: SupportLabelConfig("Nominal Label", state: .nominal))
                .menuFieldStyle(.default)
                MenuField(selection: .constant(nil),
                             options: PreviewOptions.allCases,
                          placeholder: "Support Label", supportLabelConfig: SupportLabelConfig("Caution Label", state: .caution))
                .menuFieldStyle(.default)
                MenuField(selection: .constant(nil),
                             options: PreviewOptions.allCases,
                          placeholder: "Support Label", supportLabelConfig: SupportLabelConfig("Warning Label", state: .warning))
                .menuFieldStyle(.default)
            }
        }
        .environmentObject(theme)
        .previewDisplayName("Menu Field Style")
        .preferredColorScheme(theme.baseScheme)
    }
}

#endif
