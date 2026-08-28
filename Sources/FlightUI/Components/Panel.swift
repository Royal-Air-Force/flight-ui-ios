//
//  Panel.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

// MARK: - Panel View -

public enum PanelOptions {
    case fixed
    case expandable(expanded: Bool = false)
}

public struct Panel<Content: View, Subtitle: View>: View {
    @EnvironmentObject var theme: Theme
    @State private var expanded: Bool

    private var title: String?
    private var fontStyle: FontStyle?
    private var expandable: Bool

    private var subtitle: () -> Subtitle
    private let content: () -> Content

    public init(title: String? = nil,
                fontStyle: FontStyle? = nil,
                options: PanelOptions = .fixed,
                subtitle: @escaping () -> Subtitle,
                @ViewBuilder content: @escaping () -> Content) {

        self.title = title
        self.subtitle = subtitle
        self.content = content

        if case .expandable(let expanded) = options {
            self.expandable = true
            self.expanded = expanded
        } else {
            self.expandable = false
            self.expanded = false
        }

        self.fontStyle = fontStyle
    }

    public init(title: String? = nil,
                fontStyle: FontStyle? = nil,
                options: PanelOptions = .fixed,
                @ViewBuilder content: @escaping () -> Content) where Subtitle == EmptyView {
        self.init(title: title,
                  fontStyle: fontStyle,
                  options: options,
                  subtitle: { EmptyView() },
                  content: content)
    }

    public var body: some View {
        panelView
    }

    private var panelView: some View {
        VStack {
            panelHeaderView

            if showContent {
                panelContentView
            }
        }
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous)
        .strokeBorder(theme.color.surfaceLow, lineWidth: theme.size.border)
        .background(RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous).fill(theme.color.background)))
    }

    private var panelHeaderView: some View {
        HStack {
            if let title {
                panelTitleTextView(title)
            }

            Spacer()

            subtitle()

            if expandable {
                expandIcon
            }
        }
        .background(theme.color.surfaceLow)
        .padding(.bottom, theme.padding.grid1x)
        .cornerRadius(theme.radius.medium)
        .padding(.bottom, -theme.padding.grid1x)
        .cornerRadius(showContent ? 0.0 : theme.radius.medium)
        .onTapGesture {
            guard expandable else { return }

            withAnimation {
                expanded.toggle()
            }
        }
    }

    private func panelTitleTextView(_ title: String) -> some View {
        Text(title)
            .padding()
            .foregroundColor(theme.color.primary)
            .fontStyle(fontStyle ?? theme.font.title2)
    }

    private var expandIcon: some View {
        Image(systemName: "chevron.down")
            .font(.title)
            .fontWeight(.regular)
            .foregroundColor(.white)
            .rotationEffect(.degrees(expanded ? -180.0 : 0.0))
            .padding()
    }

    private var panelContentView: some View {
        content()
            // -12.0 is a magic number, text pixel alignment is slightly off; goal is
            // to have the content "hug" the Panel and defer padding to component consumer
            .padding(.top, title == nil ? -theme.padding.grid1x / 2.0 : -12.0)
    }

    private var showContent: Bool {
        !expandable || expanded
    }
}

// MARK: - Preview Code -

#if DEBUG

struct Panel_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 32.0) {
            Panel {
                content
            }

            Panel(title: "Default Panel") {
                content
            }

            Panel(title: "Expandable Panel with subtitle", fontStyle: FontStyle.body, options: .expandable()) {
                Text("This is a subtitle")
                    .fontStyle(FontStyle.caption1)
            } content: {
                content
            }

            Panel(title: "Panel (not expanded)", options: .expandable()) {
                content
            }

            Panel(title: "Panel (expanded)", options: .expandable(expanded: true)) {
                content
            }

            HStack(alignment: .top) {
                Panel {
                    HStack {
                        Text("Side by Side")
                            .fontStyle(FontStyle.title1)
                            .padding()

                        Spacer()
                    }
                }

                Panel(title: "Side by Side", options: .expandable(expanded: false)) {
                    content
                }
            }
        }
        .environmentObject(Theme())
        .preferredColorScheme(.dark)
        .padding()
    }

    @ViewBuilder private static var content: some View {
        Text("Content")
            .fontStyle(Theme().font.title2)
            .padding()
    }
}

#endif
