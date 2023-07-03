import SwiftUI

public class ThemeButtons {
    @Published public var filled: FilledButtonStyle
    @Published public var filledIcon: FilledButtonStyle
    @Published public var tonal: TonalButtonStyle
    @Published public var outline: OutlineButtonStyle
    @Published public var text: TextButtonStyle
    
    public init(filled: FilledButtonStyle = FilledButtonStyle(iconOnly: false),
                filledIcon: FilledButtonStyle = FilledButtonStyle(iconOnly: true),
                tonal: TonalButtonStyle = TonalButtonStyle(),
                outline: OutlineButtonStyle = OutlineButtonStyle(),
                text: TextButtonStyle = TextButtonStyle()
    ) {
        self.filled = filled
        self.filledIcon = filledIcon
        self.tonal = tonal
        self.outline = outline
        self.text = text
    }
}
