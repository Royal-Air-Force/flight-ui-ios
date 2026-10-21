import SwiftUI
import FlightUI

struct HeadingView: View {
    @Environment(\.theme) var theme

    var title: String
    var subTitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.grid0_5x) {
            Text(title)
                .fontStyle(theme.typography.title1)
            Text(subTitle)
                .foregroundColor(theme.color.secondary)
                .fontStyle(theme.typography.body)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG

struct HeadingView_Previews: PreviewProvider {
    static var theme: ThemeData = .dark

    static var previews: some View {
        HeadingView(title: "This is a Preview", subTitle: "Heading View is only used in the Kitchen Sink as a consistent header to components")
            .previewDisplayName("Heading View Samples")
            .preferredColorScheme(theme.baseScheme)
    }
}

#endif
