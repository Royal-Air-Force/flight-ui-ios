//
//  HeadingView.swift
//  Flight UI - Kitchen Sink Sample
//
//  Created by Appivate 2023
//

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

#if DEBUG

struct HeadingView_Previews: PreviewProvider {
    static var theme: Theme = Theme(baseScheme: .dark)

    static var previews: some View {
        HeadingView(title: "This is a Preview", subTitle: "Heading View is only used in the Kitchen Sink as a consistent header to components")
            .environmentObject(theme)
            .previewDisplayName("Heading View Samples")
            .preferredColorScheme(theme.baseScheme)
    }
}

#endif
