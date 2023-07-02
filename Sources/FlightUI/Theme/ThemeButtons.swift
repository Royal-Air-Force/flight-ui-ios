import SwiftUI

public class ThemeButtons {
    @Published public var filled: any ButtonStyle
    
    public init(filled: any ButtonStyle = FilledButtonStyle()) {
        self.filled = filled
    }
}
