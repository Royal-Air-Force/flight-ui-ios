import SwiftUI

public class ThemeButtons {
    @Published public var filled: FilledButtonStyle
    @Published public var filledIcon: FilledIconButtonStyle
    @Published public var tonal: TonalButtonStyle
    @Published public var tonalIcon: TonalIconButtonStyle
    @Published public var outline: OutlineButtonStyle
    @Published public var outlineIcon: OutlineIconButtonStyle
    @Published public var text: TextButtonStyle
    @Published public var textIcon: TextIconButtonStyle
    
    public init(filled: FilledButtonStyle = FilledButtonStyle(),
                filledIcon: FilledIconButtonStyle = FilledIconButtonStyle(),
                tonal: TonalButtonStyle = TonalButtonStyle(),
                tonalIcon: TonalIconButtonStyle = TonalIconButtonStyle(),
                outline: OutlineButtonStyle = OutlineButtonStyle(),
                outlineIcon: OutlineIconButtonStyle = OutlineIconButtonStyle(),
                text: TextButtonStyle = TextButtonStyle(),
                textIcon: TextIconButtonStyle = TextIconButtonStyle()
    ) {
        self.filled = filled
        self.filledIcon = filledIcon
        self.tonal = tonal
        self.tonalIcon = tonalIcon
        self.outline = outline
        self.outlineIcon = outlineIcon
        self.text = text
        self.textIcon = textIcon
    }
}
