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
    
    public init(largeTitle: FontStyle = FontStyle(font: .largeTitle, lineSpacing: 34),
                title1: FontStyle = FontStyle(font: .title, lineSpacing: 28),
                title2: FontStyle = FontStyle(font: .title2, lineSpacing: 22),
                title3: FontStyle = FontStyle(font: .title3, lineSpacing: 20),
                headline: FontStyle = FontStyle(font: .headline, weight: .semibold, lineSpacing: 17),
                body: FontStyle = FontStyle(font: .body, lineSpacing: 5),
                callout: FontStyle = FontStyle(font: .callout, lineSpacing: 16),
                subhead: FontStyle = FontStyle(font: .subheadline, lineSpacing: 15),
                footnote: FontStyle = FontStyle(font: .footnote, lineSpacing: 14),
                caption1: FontStyle = FontStyle(font: .caption, lineSpacing: 12),
                caption2: FontStyle = FontStyle(font: .caption2, lineSpacing: 11)
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
