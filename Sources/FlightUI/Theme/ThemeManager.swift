import SwiftUI

public class ThemeManager: ObservableObject {
    @Published var current: Theme
    
    public init(current: Theme = .dark) {
        self.current = current
    }
}
