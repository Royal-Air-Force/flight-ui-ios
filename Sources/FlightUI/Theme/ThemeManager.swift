import SwiftUI

public class ThemeManager: ObservableObject {
    @Published public var current: Theme

    public init(current: Theme = .dark) {
        self.current = current
    }
}
