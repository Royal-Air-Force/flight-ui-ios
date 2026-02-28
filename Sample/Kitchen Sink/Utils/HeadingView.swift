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
