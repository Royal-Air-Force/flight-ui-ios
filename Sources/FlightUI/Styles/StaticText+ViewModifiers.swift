import SwiftUI

// Move to FlightUI Theme
fileprivate let fieldCornerRadius = 5.0
fileprivate let fieldBorderWidth = 5.0

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

    public init(options: StaticTextOptionSet = .none) {
        self.options = options
    }

    public func body(content: Content) -> some View {
        content
            .padding()
            .when(options.contains(.background)) { view in
                view
                    .background(theme.staticTextBackground)
                    .cornerRadius(fieldCornerRadius)
            }
            .when(options.contains(.bordered)) { view in
                view
                    .background(
                        // TODO: move cornerRadius and lineWidth to Theme
                        RoundedRectangle(cornerRadius: fieldCornerRadius, style: .continuous)
                            .stroke(theme.staticTextBorder, lineWidth: 3.0)
                    )
            }
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
    static var previews: some View {
        VStack(spacing: 32.0) {
            Text("Plain")
                .staticTextStyle(StaticTextStyle(options: .none))
                .typography(.h1)

            Text("Background")
                .staticTextStyle(StaticTextStyle(options: .background))
                .typography(.h2)

            Text("Bordered")
                .staticTextStyle(StaticTextStyle(options: .bordered))
                .typography(.h3)
                .fontWeight(.heavy)

            Text("All Options")
                .foregroundColor(Color(uiColor: .systemRed))
                .fontWeight(.bold)
                .staticTextStyle(StaticTextStyle(options: .all))
                .typography(.caption)
        }
        .environmentObject(Theme())
        .previewDisplayName("Static Text variations")
        .preferredColorScheme(.dark)
        .padding()
    }
}

#endif