//
//  FontStyle.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

/// Provides theme based customisation to Font views with the use of a view modifier
/// Extensions allow this to be implemented with Text("").fontStyle(style)
///
/// Note: Line spacing is caluclated from design tools as line height - font size
/// Note: Character spacing set to 0 uses the default value from the Font
public class FontStyle {

    private var id: UUID
    public var size: CGFloat
    public var weight: Font.Weight
    public var design: Font.Design
    public var italic: Bool
    public var lineSpacing: CGFloat
    public var charSpacing: CGFloat
    public var foregroundColor: Color?

    public init(size: CGFloat,
                weight: Font.Weight = .regular,
                design: Font.Design = .default,
                italic: Bool = false,
                lineSpacing: CGFloat,
                charSpacing: CGFloat = 0,
                foregroundColor: Color? = nil
    ) {
        self.id = UUID()
        self.size = size
        self.weight = weight
        self.design = design
        self.italic = italic
        self.lineSpacing = lineSpacing
        self.charSpacing = charSpacing
        self.foregroundColor = foregroundColor
    }
}

struct FontStyleModifier: ViewModifier {
    @EnvironmentObject var theme: Theme
    @Environment(\.sizeCategory) var sizeCategory

    let style: FontStyle
    
    let size: CGFloat?
    let weight: Font.Weight?
    let design: Font.Design?
    let isItalic: Bool?
    let lineSpacing: CGFloat?
    let charSpacing: CGFloat?
    let foregroundColour: Color?

    init(
        style: FontStyle,
        size: CGFloat? = nil,
        weight: Font.Weight? = nil,
        design: Font.Design? = nil,
        isItalic: Bool? = nil,
        lineSpacing: CGFloat? = nil,
        charSpacing: CGFloat? = nil,
        foregroundColour: Color? = nil
    ) {
        self.style = style
        self.size = size
        self.weight = weight
        self.design = design
        self.isItalic = isItalic
        self.lineSpacing = lineSpacing
        self.charSpacing = charSpacing
        self.foregroundColour = foregroundColour
    }

    func body(content: Content) -> some View {
        content
            .font(.system(
                size: size ?? UIFontMetrics.default.scaledValue(for: style.size),
                weight: weight ?? style.weight,
                design: design ?? style.design))
            .italic(isItalic ?? style.italic)
            .lineSpacing(lineSpacing ?? style.lineSpacing)
            .tracking(charSpacing ?? style.charSpacing)
            .foregroundColor(foregroundColour ?? style.foregroundColor ?? theme.color.primary)
    }

}

extension Font {
    public func italic(_ value: Bool) -> Font {
        return value ? self.italic() : self
    }
}

extension View {
    public func fontStyle(
        _ style: FontStyle,
        size: CGFloat? = nil,
        weight: Font.Weight? = nil,
        design: Font.Design? = nil,
        isItalic: Bool? = nil,
        lineSpacing: CGFloat? = nil,
        charSpacing: CGFloat? = nil,
        foregroundColour: Color? = nil
    ) -> some View {
        modifier(FontStyleModifier(style: style, size: size, weight: weight, design: design, isItalic: isItalic, lineSpacing: lineSpacing, charSpacing: charSpacing, foregroundColour: foregroundColour))
    }
}

#if DEBUG

struct FontStyle_Previews: PreviewProvider {
    static var theme: Theme = Theme(baseScheme: .dark)

    static let paragraphExample: String =
        """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore \
        et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut \
        aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse \
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, \
        sunt in culpa qui officia deserunt mollit anim id est laborum."
        """

    static var previews: some View {
        VStack(alignment: .leading, spacing: theme.padding.grid2x) {
            VStack(alignment: .leading, spacing: theme.padding.grid2x) {
                Text("Large Title").fontStyle(theme.font.largeTitle)
                Text("Title One").fontStyle(theme.font.title1)
                Text("Title Two").fontStyle(theme.font.title2)
                Text("Title Three").fontStyle(theme.font.title3)
                Text("Headline").fontStyle(theme.font.headline)
                Text("Subhead").fontStyle(theme.font.subhead)
            }
            VStack(alignment: .leading, spacing: theme.padding.grid2x) {
                Text("Body").fontStyle(theme.font.body)
                Text("Body Bold").fontStyle(theme.font.bodyBold)
                Text("Callout").fontStyle(theme.font.callout)
                Text("Footnote").fontStyle(theme.font.footnote)
                Text("Caption 1").fontStyle(theme.font.caption1)
                Text("Caption 2").fontStyle(theme.font.caption2)
            }
            Divider()
            VStack(alignment: .leading, spacing: theme.padding.grid2x) {
                Text(paragraphExample).fontStyle(theme.font.body)
                Text(paragraphExample).fontStyle(theme.font.bodyBold)
                Text(paragraphExample).fontStyle(theme.font.callout)
                Text(paragraphExample).fontStyle(theme.font.footnote)
            }
        }
        .environmentObject(theme)
        .previewDisplayName("Font Style")
        .preferredColorScheme(theme.baseScheme)
    }
}

#endif
