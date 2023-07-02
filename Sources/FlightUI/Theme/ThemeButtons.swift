import SwiftUI

public class ThemeButtons {
    @Published public var filled: FilledButtonStyle
    
    public init(filled: FilledButtonStyle = FilledButtonStyle()) {
        self.filled = filled
    }
}
