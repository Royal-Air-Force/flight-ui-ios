import SwiftUI

// MARK: - FontStyle (Immutable, Sendable)

/// Immutable, Sendable font style configuration.
/// Provides theme-based customization to Font views with the use of a view modifier.
///
/// Note: Line spacing is calculated from design tools as line height - font size
/// Note: Character spacing set to 0 uses the default value from the Font
public struct FontStyle: Sendable, Equatable {
    public let size: CGFloat
    public let weight: Font.Weight
    public let design: Font.Design
    public let italic: Bool
    public let lineSpacing: CGFloat
    public let charSpacing: CGFloat
    public let foregroundColor: Color?

    public init(
        size: CGFloat,
        weight: Font.Weight = .regular,
        design: Font.Design = .default,
        italic: Bool = false,
        lineSpacing: CGFloat,
        charSpacing: CGFloat = 0,
        foregroundColor: Color? = nil
    ) {
        self.size = size
        self.weight = weight
        self.design = design
        self.italic = italic
        self.lineSpacing = lineSpacing
        self.charSpacing = charSpacing
        self.foregroundColor = foregroundColor
    }

    /// Returns a copy with a different foreground color
    public func withColor(_ color: Color?) -> FontStyle {
        FontStyle(
            size: size,
            weight: weight,
            design: design,
            italic: italic,
            lineSpacing: lineSpacing,
            charSpacing: charSpacing,
            foregroundColor: color
        )
    }

    /// Returns a copy scaled by the given factor
    public func scaled(by factor: CGFloat) -> FontStyle {
        FontStyle(
            size: size * factor,
            weight: weight,
            design: design,
            italic: italic,
            lineSpacing: lineSpacing * factor,
            charSpacing: charSpacing * factor,
            foregroundColor: foregroundColor
        )
    }
}

// MARK: - FontStyle Factories

extension FontStyle {
    public static var largeTitle: FontStyle {
        FontStyle(size: 34, weight: .bold, lineSpacing: 7)
    }

    public static var title1: FontStyle {
        FontStyle(size: 30, weight: .semibold, lineSpacing: 3)
    }

    public static var title2: FontStyle {
        FontStyle(size: 28, lineSpacing: 3)
    }

    public static var title3: FontStyle {
        FontStyle(size: 24, lineSpacing: 2)
    }

    public static var headline: FontStyle {
        FontStyle(size: 20, weight: .semibold, lineSpacing: 2)
    }

    public static var subhead: FontStyle {
        FontStyle(size: 18, lineSpacing: 2)
    }

    public static var body: FontStyle {
        FontStyle(size: 16, lineSpacing: 2)
    }

    public static var bodyBold: FontStyle {
        FontStyle(size: 16, weight: .semibold, lineSpacing: 2)
    }

    public static var callout: FontStyle {
        FontStyle(size: 15, weight: .semibold, lineSpacing: 2, charSpacing: 2)
    }

    public static var footnote: FontStyle {
        FontStyle(size: 15, weight: .semibold, lineSpacing: 2)
    }

    public static var caption1: FontStyle {
        FontStyle(size: 15, lineSpacing: 2)
    }

    public static var caption2: FontStyle {
        FontStyle(size: 14, lineSpacing: 1)
    }
}

// MARK: - Typography Data

/// Immutable, Sendable typography configuration for a theme.
public struct ThemeTypographyData: Sendable {
    public let largeTitle: FontStyle
    public let title1: FontStyle
    public let title2: FontStyle
    public let title3: FontStyle
    public let headline: FontStyle
    public let subhead: FontStyle
    public let body: FontStyle
    public let bodyBold: FontStyle
    public let callout: FontStyle
    public let footnote: FontStyle
    public let caption1: FontStyle
    public let caption2: FontStyle

    public init(
        largeTitle: FontStyle,
        title1: FontStyle,
        title2: FontStyle,
        title3: FontStyle,
        headline: FontStyle,
        subhead: FontStyle,
        body: FontStyle,
        bodyBold: FontStyle,
        callout: FontStyle,
        footnote: FontStyle,
        caption1: FontStyle,
        caption2: FontStyle
    ) {
        self.largeTitle = largeTitle
        self.title1 = title1
        self.title2 = title2
        self.title3 = title3
        self.headline = headline
        self.subhead = subhead
        self.body = body
        self.bodyBold = bodyBold
        self.callout = callout
        self.footnote = footnote
        self.caption1 = caption1
        self.caption2 = caption2
    }
}

// MARK: - Typography Data Factories

extension ThemeTypographyData {
    /// Standard typography configuration
    public static var standard: ThemeTypographyData {
        ThemeTypographyData(
            largeTitle: .largeTitle,
            title1: .title1,
            title2: .title2,
            title3: .title3,
            headline: .headline,
            subhead: .subhead,
            body: .body,
            bodyBold: .bodyBold,
            callout: .callout,
            footnote: .footnote,
            caption1: .caption1,
            caption2: .caption2
        )
    }

    /// Returns a new typography configuration scaled by the given factor
    public func scaled(by factor: CGFloat) -> ThemeTypographyData {
        ThemeTypographyData(
            largeTitle: largeTitle.scaled(by: factor),
            title1: title1.scaled(by: factor),
            title2: title2.scaled(by: factor),
            title3: title3.scaled(by: factor),
            headline: headline.scaled(by: factor),
            subhead: subhead.scaled(by: factor),
            body: body.scaled(by: factor),
            bodyBold: bodyBold.scaled(by: factor),
            callout: callout.scaled(by: factor),
            footnote: footnote.scaled(by: factor),
            caption1: caption1.scaled(by: factor),
            caption2: caption2.scaled(by: factor)
        )
    }
}
