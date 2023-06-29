import SwiftUI

public class ThemeTypography{
    @Published public var largeTitle: Font
    @Published public var title1: Font
    @Published public var title2: Font
    @Published public var title3: Font
    @Published public var headline: Font
    @Published public var body: Font
    @Published public var callout: Font
    @Published public var subhead: Font
    @Published public var footnote: Font
    @Published public var caption1: Font
    @Published public var caption2: Font
    
    public init(largeTitle: Font = .largeTitle,
                title1: Font = .title,
                title2: Font = .title2,
                title3: Font = .title3,
                headline: Font = .headline,
                body: Font = .body,
                callout: Font = .callout,
                subhead: Font = .subheadline,
                footnote: Font = .footnote,
                caption1: Font = .caption,
                caption2: Font = .caption2
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
    
    public func largeTitleStyle(color: Color? = nil) -> some ViewModifier {
        return FontModifier(typography: largeTitle, color: color)
    }
    
    public func title1Style(color: Color? = nil) -> some ViewModifier {
        return FontModifier(typography: title1, color: color)
    }
    
    public func title2Style(color: Color? = nil) -> some ViewModifier {
        return FontModifier(typography: title2, color: color)
    }
    
    public func title3Style(color: Color? = nil) -> some ViewModifier {
        return FontModifier(typography: title3, color: color)
    }
    
    public func headlineStyle(color: Color? = nil) -> some ViewModifier {
        return FontModifier(typography: headline, color: color)
    }
    
    public func bodyStyle(color: Color? = nil) -> some ViewModifier {
        return FontModifier(typography: body, color: color)
    }
    
    public func calloutStyle(color: Color? = nil) -> some ViewModifier {
        return FontModifier(typography: callout, color: color)
    }
    
    public func subheadStyle(color: Color? = nil) -> some ViewModifier {
        return FontModifier(typography: subhead, color: color)
    }
    
    public func footnoteStyle(color: Color? = nil) -> some ViewModifier {
        return FontModifier(typography: footnote, color: color)
    }
    
    public func caption1Style(color: Color? = nil) -> some ViewModifier {
        return FontModifier(typography: caption1, color: color)
    }
    
    public func caption2Style(color: Color? = nil) -> some ViewModifier {
        return FontModifier(typography: caption2, color: color)
    }
}

struct FontModifier : ViewModifier{
    @EnvironmentObject var theme: Theme
    
    var typography: Font
    var color: Color?
    
    public init(typography: Font,
                color: Color? = nil
    ) {
        self.typography = typography
        self.color = color ?? theme.color.onSurface.color
    }
    
    public func body(content: Content) -> some View {
        return content
            .font(typography)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
    }
}
