import SwiftUI

public class ThemeButtons {
    @Published public var filled: FilledButtonStyle
    @Published public var tonal: TonalButtonStyle
    @Published public var outline: OutlineButtonStyle
    
    public init(filled: FilledButtonStyle = FilledButtonStyle(),
                tonal: TonalButtonStyle = TonalButtonStyle(),
                outline: OutlineButtonStyle = OutlineButtonStyle()
    ) {
        self.filled = filled
        self.tonal = tonal
        self.outline = outline
    }
}
