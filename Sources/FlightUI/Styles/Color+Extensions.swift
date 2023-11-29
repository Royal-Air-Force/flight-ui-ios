//
//  Color+Extensions.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

public extension Color {
    // N/A
    static let flightTransparent = Color("flightTransparent", bundle: .module)

    // Greys
    static let flightGrey0 = Color("flightGrey0", bundle: .module)
    static let flightGrey100 = Color("flightGrey100", bundle: .module)
    static let flightGrey200 = Color("flightGrey200", bundle: .module)
    static let flightGrey300 = Color("flightGrey300", bundle: .module)
    static let flightGrey400 = Color("flightGrey400", bundle: .module)
    static let flightGrey500 = Color("flightGrey500", bundle: .module)
    static let flightGrey600 = Color("flightGrey600", bundle: .module)
    static let flightGrey700 = Color("flightGrey700", bundle: .module)
    static let flightGrey800 = Color("flightGrey800", bundle: .module)
    static let flightGrey900 = Color("flightGrey900", bundle: .module)

    // Colours
    static let flightDarkBlue = Color("flightDarkBlue", bundle: .module)
    static let flightLightBlue = Color("flightLightBlue", bundle: .module)
    static let flightDarkGreen = Color("flightDarkGreen", bundle: .module)
    static let flightLightGreen = Color("flightLightGreen", bundle: .module)
    static let flightDarkYellow = Color("flightDarkYellow", bundle: .module)
    static let flightLightYellow = Color("flightLightYellow", bundle: .module)
    static let flightDarkRed = Color("flightDarkRed", bundle: .module)
    static let flightLightRed = Color("flightLightRed", bundle: .module)

    // Graphics
    static let flightGraphicsRed = Color("flightGraphicsRed", bundle: .module)
    static let flightGraphicsDarkRed = Color("flightGraphicsDarkRed", bundle: .module)
    static let flightGraphicsYellow = Color("flightGraphicsYellow", bundle: .module)
    static let flightGraphicsDarkYellow = Color("flightGraphicsDarkYellow", bundle: .module)
    static let flightGraphicsGreen = Color("flightGraphicsGreen", bundle: .module)
    static let flightGraphicsDarkGreen = Color("flightGraphicsDarkGreen", bundle: .module)
    static let flightGraphicsMint = Color("flightGraphicsMint", bundle: .module)
    static let flightGraphicsDarkMint = Color("flightGraphicsDarkMint", bundle: .module)
    static let flightGraphicsCyan = Color("flightGraphicsCyan", bundle: .module)
    static let flightGraphicsDarkCyan = Color("flightGraphicsDarkCyan", bundle: .module)
    static let flightGraphicsBlue = Color("flightGraphicsBlue", bundle: .module)
    static let flightGraphicsDarkBlue = Color("flightGraphicsDarkBlue", bundle: .module)
    static let flightGraphicsIndigo = Color("flightGraphicsIndigo", bundle: .module)
    static let flightGraphicsPurple = Color("flightGraphicsPurple", bundle: .module)
    static let flightGraphicsDarkPurple = Color("flightGraphicsDarkPurple", bundle: .module)
    static let flightGraphicsPink = Color("flightGraphicsPink", bundle: .module)
    static let flightGraphicsDarkPink = Color("flightGraphicsDarkPink", bundle: .module)
}

// MARK: - FilePrivate Preview Code -

#if DEBUG

fileprivate extension Color {
    var name: String {
        let description = self.description
        if !description.starts(with: "NamedColor") { return description }
        let firstOccurenceIndex = description.firstIndex(of: "\"") ?? description.startIndex
        let startIndex = description.index(firstOccurenceIndex, offsetBy: 1)
        let suffix = description.suffix(from: startIndex)
        let lastOccurenceIndex = suffix.firstIndex(of: "\"") ?? description.endIndex
        let name = suffix.prefix(upTo: lastOccurenceIndex)
        return String(name)
    }

    static let generalColors: [Color] = [.flightGrey0,
                                       .flightGrey100,
                                       .flightGrey200,
                                       .flightGrey300,
                                       .flightGrey400,
                                       .flightGrey500,
                                       .flightGrey600,
                                       .flightGrey700,
                                       .flightGrey800,
                                       .flightGrey900]

    static let coreColors: [Color] = [.flightDarkBlue,
                                      .flightLightBlue,
                                      .flightDarkGreen,
                                      .flightLightGreen,
                                      .flightDarkYellow,
                                      .flightLightYellow,
                                      .flightDarkRed,
                                      .flightLightRed]

    static let graphicsColors: [Color] = [.flightGraphicsRed,
                                          .flightGraphicsDarkRed,
                                          .flightGraphicsYellow,
                                          .flightGraphicsDarkYellow,
                                          .flightGraphicsGreen,
                                          .flightGraphicsDarkGreen,
                                          .flightGraphicsMint,
                                          .flightGraphicsDarkMint,
                                          .flightGraphicsCyan,
                                          .flightGraphicsDarkCyan,
                                          .flightGraphicsBlue,
                                          .flightGraphicsDarkBlue,
                                          .flightGraphicsIndigo,
                                          .flightGraphicsPurple,
                                          .flightGraphicsDarkPurple,
                                          .flightGraphicsPink,
                                          .flightGraphicsDarkPink]

    static let customColors: [Color] = generalColors + coreColors + graphicsColors
}

struct Color_Previews: PreviewProvider {
    static var theme: Theme = Theme(baseScheme: .dark)

    static var previews: some View {
        List(Color.customColors, id: \.self) { color in
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.gray, lineWidth: 3.0)
                    .background(color)
                    .frame(width: 75, height: 75)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Text("\(color.name)")
                    .fontStyle(Theme().font.title2)
                    .padding()
            }
        }
        .environmentObject(theme)
        .preferredColorScheme(theme.baseScheme)
        .previewDisplayName("All Colors")
        .padding()
    }
}

#endif
