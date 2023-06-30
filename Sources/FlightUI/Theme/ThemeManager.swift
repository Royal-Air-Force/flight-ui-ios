import SwiftUI

public class ThemeManager: ObservableObject {
    @Published var current: Theme = .dark
}
