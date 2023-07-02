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
    
    public init(largeTitle: FontStyle = FontStyle(font: .largeTitle, weight: .regular, design: .default, italic: false, lineSpacing: 34, charSpacing: 1, foregroundColor: nil),

                title1: FontStyle = FontStyle(font: .title, weight: .regular, design: .default, italic: false, lineSpacing: 28, charSpacing: 1, foregroundColor: nil),
                
                title2: FontStyle = FontStyle(font: .title2, weight: .regular, design: .default, italic: false, lineSpacing: 22, charSpacing: 1, foregroundColor: nil),
                
                title3: FontStyle = FontStyle(font: .title3, weight: .regular, design: .default, italic: false, lineSpacing: 20, charSpacing: 1, foregroundColor: nil),
                
                headline: FontStyle = FontStyle(font: .headline, weight: .semibold, design: .default, italic: false, lineSpacing: 17, charSpacing: 1, foregroundColor: nil),
                
                body: FontStyle = FontStyle(font: .body, weight: .regular, design: .default, italic: false, lineSpacing: 17, charSpacing: 1, foregroundColor: nil),
                
                callout: FontStyle = FontStyle(font: .callout, weight: .regular, design: .default, italic: false, lineSpacing: 16, charSpacing: 1, foregroundColor: nil),
                
                subhead: FontStyle = FontStyle(font: .subheadline, weight: .regular, design: .default, italic: false, lineSpacing: 15, charSpacing: 1, foregroundColor: nil),
                
                footnote: FontStyle = FontStyle(font: .footnote, weight: .regular, design: .default, italic: false, lineSpacing: 14, charSpacing: 1, foregroundColor: nil),
                
                caption1: FontStyle = FontStyle(font: .caption, weight: .regular, design: .default, italic: false, lineSpacing: 12, charSpacing: 1, foregroundColor: nil),
                
                caption2: FontStyle = FontStyle(font: .caption2, weight: .regular, design: .default, italic: false, lineSpacing: 11, charSpacing: 1, foregroundColor: nil)) {
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
