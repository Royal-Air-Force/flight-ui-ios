import SwiftUI

public extension FontStyle {
    static var largeTitle: FontStyle {
        return FontStyle(size: 34, lineSpacing: 7)
    }
    static var title1: FontStyle {
        return FontStyle(size: 30, weight: .semibold, lineSpacing: 3)
    }
    static var title2: FontStyle {
        return FontStyle(size: 28, lineSpacing: 3)
    }
    static var title3: FontStyle {
        return FontStyle(size: 24, lineSpacing: 2)
    }
    static var headline: FontStyle {
        return FontStyle(size: 20, weight: .semibold, lineSpacing: 2)
    }
    static var subhead: FontStyle {
        return FontStyle(size: 18, lineSpacing: 2)
    }
    static var body: FontStyle {
        return FontStyle(size: 16, lineSpacing: 2)
    }
    static var bodyBold: FontStyle {
        return FontStyle(size: 16, weight: .semibold, lineSpacing: 2)
    }
    static var callout: FontStyle {
        return FontStyle(size: 15, weight: .semibold, lineSpacing: 2, charSpacing: 2)
    }
    static var footnote: FontStyle {
        return FontStyle(size: 15, weight: .semibold, lineSpacing: 2)
    }
    static var caption1: FontStyle {
        return FontStyle(size: 15, lineSpacing: 2)
    }
    static var caption2: FontStyle {
        return FontStyle(size: 14, lineSpacing: 1)
    }
}
