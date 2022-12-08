//
//  File.swift
//  
//
//  Created by Alan Gorton on 08/12/2022.
//

import SwiftUI

fileprivate let fieldCornerRadius = 5.0
fileprivate let fieldBorderWidth = 5.0

// MARK: - Static Text View Modifiers -

struct StaticTextOptionSet: OptionSet {
    let rawValue: UInt8

    static let background = StaticTextOptionSet(rawValue: 0x1)
    static let bordered = StaticTextOptionSet(rawValue: 0x2)

    static let none = StaticTextOptionSet([])
    static let all: StaticTextOptionSet = [.background, .bordered]
}

struct StaticTextStyle: ViewModifier {
    private let options: StaticTextOptionSet

    init(options: StaticTextOptionSet = .none) {
        self.options = options
    }

    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.ballisticPrimary)
            .when(options.contains(.background)) { view in
                view
                    .background(Color.neutralDarkGray)
                    .cornerRadius(fieldCornerRadius)
            }
            .when(options.contains(.bordered)) { view in
                view
                    .background(
                    // TODO: move cornerRadius and lineWidth to Theme
                    RoundedRectangle(cornerRadius: fieldCornerRadius, style: .continuous)
                        .stroke(Color.ballisticPrimary, lineWidth: 3.0)
                )
            }
    }
}

// MARK: - Text View Extensions -

extension Text {
    func staticTextStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

// MARK: - Preview Code -

#if DEBUG

struct StaticText_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 32.0) {
            Text("Plain")
                .font(.headline)
                .staticTextStyle(StaticTextStyle(options: .none))

            Text("Background")
                .font(.subheadline)
                .staticTextStyle(StaticTextStyle(options: .background))

            Text("Bordered")
                .font(.title)
                .staticTextStyle(StaticTextStyle(options: .bordered))

            Text("All Options")
                .font(.largeTitle)
                .staticTextStyle(StaticTextStyle(options: .all))
        }
        .preferredColorScheme(.dark)
        .padding()
    }
}

#endif
