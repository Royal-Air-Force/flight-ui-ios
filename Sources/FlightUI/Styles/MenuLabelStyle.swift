import SwiftUI

struct MenuLabelStyle: LabelStyle {
    var textColor: Color

    init(textColor: Color) {
        self.textColor = textColor
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .title.foregroundColor(textColor)
    }
}
