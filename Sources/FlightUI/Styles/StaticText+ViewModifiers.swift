import SwiftUI

// MARK: - Static Text View Modifiers -

public struct StaticTextOptionSet: OptionSet {
    public let rawValue: UInt8

    public static let background = StaticTextOptionSet(rawValue: 0x1)
    public static let bordered = StaticTextOptionSet(rawValue: 0x2)

    public static let none = StaticTextOptionSet([])
    public static let all = StaticTextOptionSet([.background, .bordered])

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
}

public struct StaticTextStyle: ViewModifier {
    @EnvironmentObject var theme: Theme
    private let options: StaticTextOptionSet
    private let size: TextFieldSize

    public init(options: StaticTextOptionSet = .none,
                size: TextFieldSize = .infinity) {
        self.options = options
        self.size = size
    }

    public func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: size.width(theme: theme), height: theme.textFieldHeight)
            .background(options.contains(.background) ? theme.staticTextBackground : .clear)
            .cornerRadius(options.contains(.background) ? theme.staticTextFieldCornerRadius : 0)
            .background(
                // TODO: move cornerRadius and lineWidth to Theme
                RoundedRectangle(cornerRadius: options.contains(.bordered) ? theme.staticTextFieldCornerRadius : 0, style: .continuous)
                    .stroke(options.contains(.bordered) ? theme.staticTextBorder : .clear, lineWidth: theme.staticTextFieldBorderWidth)
            )
    }
}

// MARK: - Text View Extensions -

extension Text {
    public func staticTextStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

// MARK: - Preview Code -

#if DEBUG

struct StaticText_Previews: PreviewProvider {
    static let theme: Theme = .dark
    
    static var previews: some View {
        VStack(spacing: 32.0) {
            Text("Plain")
                .staticTextStyle(StaticTextStyle(options: .none))
                .fontStyle(theme.font.body)

            Text("Background")
                .staticTextStyle(StaticTextStyle(options: .background))
                .fontStyle(theme.font.body)

            Text("Bordered")
                .staticTextStyle(StaticTextStyle(options: .bordered))
                .fontStyle(theme.font.body)
                .fontWeight(.heavy)

            Text("All Options")
                .foregroundColor(Color(uiColor: .systemRed))
                .fontWeight(.bold)
                .staticTextStyle(StaticTextStyle(options: .all))
                .fontStyle(theme.font.caption1)
        }
        .environmentObject(theme)
        .previewDisplayName("Static Text variations")
        .preferredColorScheme(.dark)
        .padding()
    }
}

#endif
