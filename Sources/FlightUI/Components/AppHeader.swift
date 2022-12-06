//
//  AppHeader.swift
//  eTanker
//
//  Created by Alan Gorton on 21/11/2022.
//

import SwiftUI

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
        .background(Color(uiColor: .secondarySystemBackground))
    }
}

struct AppHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AppHeader {
                Text("Dark Header")
            }

            Spacer()
        }
        .previewDisplayName("Tanker (dark)")
        .preferredColorScheme(.dark)

        VStack {
            AppHeader {
                Text("Light Header")

            }

            Spacer()
        }
        .previewDisplayName("Tanker (light)")
        .preferredColorScheme(.light)
    }
}
