//
//  ThemeFont.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

public class ThemeFont {
    @Published public var largeTitle: FontStyle
    @Published public var title1: FontStyle
    @Published public var title2: FontStyle
    @Published public var title3: FontStyle
    @Published public var headline: FontStyle
    @Published public var body: FontStyle
    @Published public var bodyBold: FontStyle
    @Published public var callout: FontStyle
    @Published public var subhead: FontStyle
    @Published public var footnote: FontStyle
    @Published public var caption1: FontStyle
    @Published public var caption2: FontStyle

    public init(largeTitle: FontStyle = .largeTitle,
                title1: FontStyle = .title1,
                title2: FontStyle = .title2,
                title3: FontStyle = .title3,
                headline: FontStyle = .headline,
                body: FontStyle = .body,
                bodyBold: FontStyle = .bodyBold,
                callout: FontStyle = .callout,
                subhead: FontStyle = .subhead,
                footnote: FontStyle = .footnote,
                caption1: FontStyle = .caption1,
                caption2: FontStyle = .caption2
    ) {
        self.largeTitle = largeTitle
        self.title1 = title1
        self.title2 = title2
        self.title3 = title3
        self.headline = headline
        self.body = body
        self.bodyBold = bodyBold
        self.callout = callout
        self.subhead = subhead
        self.footnote = footnote
        self.caption1 = caption1
        self.caption2 = caption2
    }

}
