import SwiftUI

// MARK: - AppHeader Structs -

public struct AppHeader<Content: View>: View {
    private var content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        HStack {
            Spacer()

            content()

            Spacer()
        }
        .padding()
        .background(Color.neutralBlack)
    }
}

// MARK: - Preview Code -

#if DEBUG
struct AppHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AppHeader {
                Text("Dark Header")
            }

            Spacer()
        }
        .previewDisplayName("Header")
        .preferredColorScheme(.dark)
    }
}
#endif
