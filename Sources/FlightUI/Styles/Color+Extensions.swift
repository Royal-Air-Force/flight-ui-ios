import SwiftUI

// MARK: - Color Extension -

public extension Color {
    static let ballisticPrimary = Color("ballisticPrimary", bundle: .module)
    static let ballisticSecondary = Color("ballisticSecondary", bundle: .module)
    static let neutralBlack = Color("neutralBlack", bundle: .module)
    static let neutralDarkGray = Color("neutralDarkGray", bundle: .module)
    static let neutralLightGray = Color("neutralLightGray", bundle: .module)
    static let neutralBlue = Color("neutralBlue", bundle: .module)
    static let warning = Color("warning", bundle: .module)
    static let error = Color("error", bundle: .module)
}

// MARK: - FilePrivate Preview Code -

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
    
    static let customColors: [Color] = [.ballisticPrimary,
                                        .ballisticSecondary,
                                        .neutralBlack,
                                        .neutralDarkGray,
                                        .neutralLightGray,
                                        .neutralBlue,
                                        .warning,
                                        .error]
}

struct Color_Previews: PreviewProvider {
    static var colorList: some View {
        NavigationStack {
            List(Color.customColors, id: \.self) { color in
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.gray, lineWidth: 2)
                        .background(color)
                        .frame(width: 75, height: 75)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text("\(color.name)")
                        .font(.title2)
                }
            }
            .navigationTitle("Colors")
        }
    }
    
    static var previews: some View {
        colorList
            .preferredColorScheme(.dark)
            .previewDisplayName("All Colors (Dark)")
        
        colorList
            .preferredColorScheme(.light)
            .previewDisplayName("All Colors (Light)")
        
    }
}
