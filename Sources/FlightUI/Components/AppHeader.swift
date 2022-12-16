import SwiftUI

// MARK: - AppHeader View -

public struct AppHeader<Content: View>: View {
    @EnvironmentObject var theme: Theme
    
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
        .background(theme.appHeaderBackground)
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
        .environmentObject(Theme())
        .previewDisplayName("Header")
        .preferredColorScheme(.dark)
    }
}

#endif
