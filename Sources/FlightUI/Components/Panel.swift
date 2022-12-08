import SwiftUI

// MARK: - Panel View -

public struct Panel<Content: View>: View {
    @State private var expanded = false

    private var title: String?
    private var expandable: Bool

    private let content: () -> Content

    private let cornerRadius = 16.0
    private let lineWidth = 6.0

    private let panelColor = Color.neutralDarkGray

    public init(title: String? = nil, expandable: Bool = false, expanded isExpanded: Bool = false, @ViewBuilder content: @escaping () -> Content) {

        self.title = title
        self.expandable = expandable
        self.expanded = isExpanded
        self.content = content
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
            .strokeBorder(panelColor, lineWidth: lineWidth)
            .background(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous).fill(Color.black)))
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
        .background(panelColor)
        .padding(.bottom, cornerRadius)
        .cornerRadius(cornerRadius)
        .padding(.bottom, -cornerRadius)
        .padding(.top, cornerRadius)
        .cornerRadius(showContent ? 0 : cornerRadius)
        .padding(.top, -cornerRadius)
    }

    private func panelTitleTextView(_ title: String) -> some View {
        Text(title)
            .padding()
            .font(.title)
            .fontDesign(.rounded)
            .fontWeight(.bold)
            .foregroundColor(Color.ballisticPrimary)
    }

    private var expandIcon: some View {
        Image(systemName: "chevron.down")
            .font(.title)
            .foregroundColor(Color.ballisticPrimary)
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
            .padding(.top, title == nil ? 0.0 : -1.0)
            .padding([.leading, .trailing, .bottom])
    }

    private var showContent: Bool {
        !expandable || expanded
    }
}

// MARK: - Preview Code -

#if DEBUG

struct Panel_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 32) {
            Panel {
                content
            }

            Panel(title: "Preferences") {
                content
            }

            Panel(title: "Preferences (not expanded)", expandable: true) {
                content
            }

            Panel(title: "Preferences (expanded)", expandable: true, expanded: true) {
                content
            }

            HStack {
                Panel {
                    return Text("Side by Side")
                        .font(.title)
                }

                Panel(title: "Side by Side", expandable: true) {
                    content
                }
            }
        }
        .preferredColorScheme(.dark)
        .padding()
    }

    private static var content: some View {
        return Text("Content")
            .font(.title)
    }
}

#endif
