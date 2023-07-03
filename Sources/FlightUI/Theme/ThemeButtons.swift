import SwiftUI

public class ThemeButtons {
    @Published public var filled: FilledButtonStyle
    @Published public var filledIcon: FilledIconButtonStyle
    @Published public var tonal: TonalButtonStyle
    @Published public var outline: OutlineButtonStyle
    @Published public var text: TextButtonStyle
    
    public init(filled: FilledButtonStyle = FilledButtonStyle(),
                filledIcon: FilledIconButtonStyle = FilledIconButtonStyle(),
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
