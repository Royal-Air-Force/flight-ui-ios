import SwiftUI

public class ThemeButtons {
    @Published public var filled: FilledButtonStyle
    @Published public var outline: OutlineButtonStyle
    
    public init(filled: FilledButtonStyle = FilledButtonStyle(),
                outline: OutlineButtonStyle = OutlineButtonStyle()
    ) {
        self.filled = filled
        self.outline = outline
    }
}
