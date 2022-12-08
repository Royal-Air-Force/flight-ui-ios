import SwiftUI

// MARK: - Panel Structs -

public struct Panel<Content: View>: View {
    @State private var expanded = false

    private let title: String?
    private let expandable: Bool

    private var content: () -> Content

    private let cornerRadius = 16.0
    private let lineWidth = 6.0

    private let panelColor = Color.neutralDarkGray

    public init(title: String? = nil, expandable: Bool = false, @ViewBuilder content: @escaping () -> Content) {

        self.title = title
        self.expandable = expandable
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
        .onTapGesture {
            guard expandable else { return }

            withAnimation {
                expanded.toggle()
            }
        }
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
    }

    private var panelContentView: some View {
        content()
            .padding(.top, cornerRadius / 2)
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
        Group {
            Panel {
                content
            }
            .previewDisplayName("Content Only")
            .preferredColorScheme(.dark)


            Panel(title: "Preferences") {
                content
            }
            .previewDisplayName("Title")
            .preferredColorScheme(.dark)

            Panel(title: "Preferences", expandable: true) {
                content
            }
            .previewDisplayName("Expandable")
            .preferredColorScheme(.dark)
        }
        .padding()
    }

    private static var content: some View {
        return Text("Content")
            .font(.title)
    }
}
#endif
