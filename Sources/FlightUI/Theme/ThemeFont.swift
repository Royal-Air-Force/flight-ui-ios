import SwiftUI

public class ThemeFont {
    @Published public var largeTitle: FontStyle
    @Published public var title1: FontStyle
    @Published public var title2: FontStyle
    @Published public var title3: FontStyle
    @Published public var headline: FontStyle
    @Published public var body: FontStyle
    @Published public var callout: FontStyle
    @Published public var subhead: FontStyle
    @Published public var footnote: FontStyle
    @Published public var caption1: FontStyle
    @Published public var caption2: FontStyle
    
    public init(largeTitle: FontStyle = FontStyle(font: .largeTitle, lineSpacing: 7),
                title1: FontStyle = FontStyle(font: .title, lineSpacing: 6),
                title2: FontStyle = FontStyle(font: .title2, lineSpacing: 6),
                title3: FontStyle = FontStyle(font: .title3, lineSpacing: 5),
                headline: FontStyle = FontStyle(font: .headline, weight: .semibold, lineSpacing: 5),
                body: FontStyle = FontStyle(font: .body, lineSpacing: 5),
                callout: FontStyle = FontStyle(font: .callout, lineSpacing: 5),
                subhead: FontStyle = FontStyle(font: .subheadline, lineSpacing: 5),
                footnote: FontStyle = FontStyle(font: .footnote, lineSpacing: 5),
                caption1: FontStyle = FontStyle(font: .caption, lineSpacing: 4),
                caption2: FontStyle = FontStyle(font: .caption2, lineSpacing: 2)
    ) {
        self.largeTitle = largeTitle
        self.title1 = title1
        self.title2 = title2
        self.title3 = title3
        self.headline = headline
        self.body = body
        self.callout = callout
        self.subhead = subhead
        self.footnote = footnote
        self.caption1 = caption1
        self.caption2 = caption2
    }

}
