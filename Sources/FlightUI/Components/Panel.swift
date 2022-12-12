import SwiftUI

// MARK: - Panel View -

public enum PanelOptions {
    case fixed
    case expandable(expanded: Bool = false)
}

public struct Panel<Content: View>: View {
    @EnvironmentObject var theme: Theme
    @State private var expanded: Bool

    private var title: String?
    private var expandable: Bool

    private let content: () -> Content

    private let cornerRadius = 16.0
    private let lineWidth = 6.0

    public init(title: String? = nil, options: PanelOptions = .fixed, @ViewBuilder content: @escaping () -> Content) {

        self.title = title
        self.content = content

        if case .expandable(let expanded) = options {
            self.expandable = true
            self.expanded = expanded
        } else {
            self.expandable = false
            self.expanded = false
        }
    }

    public var body: some View {
        panelView
    }

    private var panelView: some View {
        VStack {
            panelHeaderView

            if (showContent) {
                panelContentView
            }
        }
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .strokeBorder(theme.panelBackground, lineWidth: lineWidth)
            .background(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous).fill(theme.panelViewBackground)))
    }

    private var panelHeaderView: some View {
        HStack {
            if let title {
                panelTitleTextView(title)
            }

            Spacer()

            if expandable {
                expandIcon
            }
        }
        .background(theme.panelBackground)
        .padding(.bottom, cornerRadius)
        .cornerRadius(cornerRadius)
        .padding(.bottom, -cornerRadius)
        .cornerRadius(showContent ? 0.0 : cornerRadius)
    }

    private func panelTitleTextView(_ title: String) -> some View {
        Text(title)
            .padding()
            .typography(.h1)
            .foregroundColor(theme.panelForegoround)
    }

    private var expandIcon: some View {
        Image(systemName: "chevron.down")
            .typography(.h1)
            .fontWeight(.regular)
            .foregroundColor(theme.panelForegoround)
            .rotationEffect(.degrees(expanded ? -180.0 : 0.0))
            .padding()
            .onTapGesture {
                guard expandable else { return }

                withAnimation {
                    expanded.toggle()
                }
            }
    }

    private var panelContentView: some View {
        content()
            // -12.0 is a magic number, text pixel alignment is slightly off; goal is
            // to have the content "hug" the Panel and defer padding to component consumer
            .padding(.top, title == nil ? -cornerRadius / 2.0 : -12.0)
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

            Panel(title: "Preferences") {
                content
            }

            Panel(title: "Preferences (not expanded)", options: .expandable()) {
                content
            }

            Panel(title: "Preferences (expanded)", options: .expandable(expanded: true)) {
                content
            }

            HStack(alignment: .top) {
                Panel {
                    HStack {
                        Text("Side by Side")
                            .typography(.h1)
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
            .typography(.h2)
            .padding()
    }
}

#endif
