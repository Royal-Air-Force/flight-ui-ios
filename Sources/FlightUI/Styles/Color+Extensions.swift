import SwiftUI

// MARK: - Color Extension -

public class ColorState {
    @Published public var `default`: Color
    @Published public var focusedColor: Color
    @Published public var disabledColor: Color
    
    public init(color: Color) {
        self.default = color
        self.focusedColor = color.opacity(0.87)
        self.disabledColor = color.opacity(0.38)
    }
    
    public init(color: Color, focusedColor: Color, disabledColor: Color) {
        self.default = color
        self.focusedColor = focusedColor
        self.disabledColor = disabledColor
    }
    
    public func getColorForState(disabled: Bool, focused: Bool) -> Color {
        if (disabled) {
            return self.disabledColor
        } else if (focused) {
            return self.focusedColor
        } else {
            return self.default
        }
    }
}

public extension Color {
    // General
    static let flightBlack = Color("flightBlack", bundle: .module)
    static let flightDarkGrey = Color("flightDarkGrey", bundle: .module)
    static let flightGrey = Color("flightGrey", bundle: .module)
    static let flightLightGrey = Color("flightLightGrey", bundle: .module)
    static let flightWhite = Color("flightWhite", bundle: .module)
    
    // Core
    static let flightInputOutput = Color("flightBlue", bundle: .module)
    static let flightNominal = Color("flightGreen", bundle: .module)
    static let flightCaution = Color("flightYellow", bundle: .module)
    static let flightWarning = Color("flightRed", bundle: .module)
    
    // Graphics
    static let flightGraphicsRed = Color("flightGraphicsRed", bundle: .module)
    static let flightGraphicsYellow = Color("flightGraphicsYellow", bundle: .module)
    static let flightGraphicsGreen = Color("flightGraphicsGreen", bundle: .module)
    static let flightGraphicsMint = Color("flightGraphicsMint", bundle: .module)
    static let flightGraphicsCyan = Color("flightGraphicsCyan", bundle: .module)
    static let flightGraphicsBlue = Color("flightGraphicsBlue", bundle: .module)
    static let flightGraphicsIndigo = Color("flightGraphicsIndigo", bundle: .module)
    static let flightGraphicsPurple = Color("flightGraphicsPurple", bundle: .module)
    static let flightGraphicsPink = Color("flightGraphicsPink", bundle: .module)
}

// MARK: - FilePrivate Preview Code -

#if DEBUG

fileprivate extension Color {
    var name: String {
        let description = self.description
        if !description.starts(with: "NamedColor") { return description }
        let firstOccurenceIndex = description.firstIndex(of: "\"") ?? description.startIndex
        let startIndex = description.index(firstOccurenceIndex, offsetBy: 1)
        let suffix = description.suffix(from: startIndex)
        let lastOccurenceIndex = suffix.firstIndex(of: "\"") ?? description.endIndex
        let name = suffix.prefix(upTo: lastOccurenceIndex)
        return String(name)
    }
    
    static let generalColors: [Color] = [.flightBlack,
                                         .flightDarkGrey,
                                         .flightGrey,
                                         .flightLightGrey,
                                         .flightWhite]
    
    static let coreColors: [Color] = [.flightInputOutput,
                                      .flightNominal,
                                      .flightCaution,
                                      .flightWarning]
    
    static let graphicsColors: [Color] = [.flightGraphicsRed,
                                          .flightGraphicsYellow,
                                          .flightGraphicsGreen,
                                          .flightGraphicsMint,
                                          .flightGraphicsCyan,
                                          .flightGraphicsBlue,
                                          .flightGraphicsIndigo,
                                          .flightGraphicsPurple,
                                          .flightGraphicsPink]
    
    static let customColors: [Color] = generalColors + coreColors + graphicsColors
}

struct Color_Previews: PreviewProvider {
    static var colorList: some View {
        NavigationStack {
            List(Color.customColors, id: \.self) { color in
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.gray, lineWidth: 3.0)
                        .background(color)
                        .frame(width: 75, height: 75)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                    Text("\(color.name)")
                        .fontStyle(Theme().font.title2)
                        .padding()
                }
            }
            .navigationTitle("Colors")
        }
    }
    
    static var previews: some View {
        colorList
            .preferredColorScheme(.dark)
            .previewDisplayName("All Colors")
            .padding()
            .environmentObject(Theme())
    }
}

#endif
