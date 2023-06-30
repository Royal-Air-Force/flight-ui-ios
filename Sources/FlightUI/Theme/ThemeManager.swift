import SwiftUI

class ThemeManager: ObservableObject {
    @Published var current: Theme = .dark
}
