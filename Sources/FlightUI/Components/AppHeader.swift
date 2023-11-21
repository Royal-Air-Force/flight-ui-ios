import SwiftUI

// MARK: - AppHeader View -

public struct AppHeader<Content: View>: View {
    @EnvironmentObject var theme: Theme

    private var content: () -> Content
    private var title: String?
    private var imageName: String?
    private var bundle: Bundle?
    private var typography: Font?
    private let useContent: Bool

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.useContent = true
    }

    public init (title: String? = nil,
                 typography: Font? = nil,
                 imageName: String? = nil,
                 bundle: Bundle? = nil) where Content == EmptyView {
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

// MARK: - Preview Code -

#if DEBUG

struct AppHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AppHeader {
                Text("Custom View App Header")
            }

            AppHeader(title: "App Header")

            AppHeader(title: "FlightUI",
                      typography: Font.title3,
                      imageName: "plane",
                      bundle: .module)

            AppHeader(imageName: "plane",
                      bundle: .module)

            Spacer()
        }
        .background(Color.flightGrey0)
        .environmentObject(Theme())
        .previewDisplayName("Header")
        .preferredColorScheme(.dark)
    }
}

#endif
