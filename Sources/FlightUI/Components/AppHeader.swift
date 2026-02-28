import SwiftUI

// MARK: - App Header View

public struct AppHeader<Content: View>: View {
    @Environment(\.theme) var theme

    private var content: () -> Content
    private var title: String?
    private var imageName: String?
    private var bundle: Bundle?
    private var typography: Font?
    private let useContent: Bool

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.title = nil
        self.imageName = nil
        self.bundle = nil
        self.typography = nil
        self.useContent = true
    }

    public init(
        title: String? = nil,
        typography: Font? = nil,
        imageName: String? = nil,
        bundle: Bundle? = nil
    ) where Content == EmptyView {
        self.title = title
        self.typography = typography
        self.imageName = imageName
        self.bundle = bundle
        self.content = { EmptyView() }
        self.useContent = false
    }

    public var body: some View {
        HStack {
            Spacer()

            if useContent {
                content()
            } else {
                if let imageName {
                    Image(imageName, bundle: bundle)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(5)
                }
                if let title {
                    Text(title)
                        .font(typography ?? Font.title3)
                }
            }
            Spacer()
        }
        .padding()
        .background(theme.color.background)
    }
}
