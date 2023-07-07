import SwiftUI

public extension FontStyle {
    static var largeTitle: FontStyle {
        return FontStyle(font: .largeTitle, lineSpacing: 7)
    }
    static var title1: FontStyle {
        return FontStyle(font: .title, lineSpacing: 6)
    }
    static var title2: FontStyle {
        return FontStyle(font: .title2, lineSpacing: 6)
    }
    static var title3: FontStyle {
        return FontStyle(font: .title3, lineSpacing: 5)
    }
    static var headline: FontStyle {
        return FontStyle(font: .headline, weight: .semibold, lineSpacing: 5)
    }
    static var body: FontStyle {
        return FontStyle(font: .body, lineSpacing: 5)
    }
    static var callout: FontStyle {
        return FontStyle(font: .callout, lineSpacing: 5)
    }
    static var subhead: FontStyle {
        return FontStyle(font: .subheadline, lineSpacing: 5)
    }
    static var footnote: FontStyle {
        return FontStyle(font: .footnote, lineSpacing: 5)
    }
    static var caption1: FontStyle {
        return FontStyle(font: .caption, lineSpacing: 4)
    }
    static var caption2: FontStyle {
        return FontStyle(font: .caption2, lineSpacing: 2)
    }
}
