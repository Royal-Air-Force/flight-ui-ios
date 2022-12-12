import SwiftUI

// MARK: - Color Extension -

public extension Color {
    static let flightWhite = Color("flightWhite", bundle: .module)
    static let flightGreen = Color("flightGreen", bundle: .module)
    static let flightBlack = Color("flightBlack", bundle: .module)
    static let flightDarkGray = Color("flightDarkGray", bundle: .module)
    static let flightLightGray = Color("flightLightGray", bundle: .module)
    static let flightBlue = Color("flightBlue", bundle: .module)
    static let flightYellow = Color("flightYellow", bundle: .module)
    static let flightOrange = Color("flightOrange", bundle: .module)
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
    
    static let customColors: [Color] = [.flightWhite,
                                        .flightGreen,
                                        .flightBlack,
                                        .flightDarkGray,
                                        .flightLightGray,
                                        .flightBlue,
                                        .flightYellow,
                                        .flightOrange]
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
                        .typography(.h2)
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
    }
}

#endif
