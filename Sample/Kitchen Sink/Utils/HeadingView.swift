import SwiftUI
import FlightUI

struct HeadingView: View {
    @EnvironmentObject var theme: Theme

    var title: String
    var subTitle: String

    var body: some View {
        VStack {
            Text(title)
                .fontStyle(theme.font.title1)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(subTitle)
                .foregroundColor(theme.color.secondary)
                .fontStyle(theme.font.body)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
    }
}