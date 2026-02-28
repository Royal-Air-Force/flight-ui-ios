import SwiftUI

// MARK: - Panel Options

public enum PanelOptions: Sendable {
    case fixed
    case expandable(expanded: Bool = false)
}

// MARK: - Panel View

public struct Panel<Content: View, Subtitle: View>: View {
    @Environment(\.theme) var theme
    @State private var expanded: Bool

    private var title: String?
    private var typography: Font?
    private var expandable: Bool

    private var subtitle: () -> Subtitle
    private let content: () -> Content

    public init(
        title: String? = nil,
        typography: Font? = nil,
        options: PanelOptions = .fixed,
        subtitle: @escaping () -> Subtitle,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.content = content

        if case .expandable(let expanded) = options {
            self.expandable = true
            self._expanded = State(initialValue: expanded)
        } else {
            self.expandable = false
            self._expanded = State(initialValue: false)
        }

        self.typography = typography
    }

    public init(
        title: String? = nil,
        typography: Font? = nil,
        options: PanelOptions = .fixed,
        @ViewBuilder content: @escaping () -> Content
    ) where Subtitle == EmptyView {
        self.init(
            title: title,
            typography: typography,
            options: options,
            subtitle: { EmptyView() },
            content: content
        )
    }

    public var body: some View {
        panelView
    }

    private var panelView: some View {
        VStack(spacing: 0) {
            panelHeaderView

            if showContent {
                panelContentView
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous)
                .strokeBorder(theme.color.surfaceLow, lineWidth: theme.size.border)
                .background(
                    RoundedRectangle(cornerRadius: theme.radius.medium, style: .continuous)
                        .fill(theme.color.background)
                )
        )
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
        .padding(.bottom, theme.spacing.grid1x)
        .cornerRadius(theme.radius.medium)
        .padding(.bottom, -theme.spacing.grid1x)
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
            .padding(.horizontal, theme.spacing.grid2x)
            .padding(.vertical, theme.spacing.grid2x)
            .font(typography ?? Font.title2)
            .foregroundColor(theme.color.surfaceLow)
    }

    private var expandIcon: some View {
        Image(systemName: "chevron.down")
            .font(.title)
            .fontWeight(.regular)
            .foregroundColor(theme.color.surfaceLow)
            .rotationEffect(.degrees(expanded ? -180.0 : 0.0))
            .padding()
    }

    private var panelContentView: some View {
        content()
    }

    private var showContent: Bool {
        !expandable || expanded
    }
}
