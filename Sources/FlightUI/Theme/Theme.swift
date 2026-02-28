import SwiftUI
import Observation

// MARK: - Observable Theme Manager

/// Observable theme manager for app-level reactivity.
/// Use this at the root of your app to enable theme switching.
@Observable
@MainActor
public final class ThemeManager {
    /// The current theme data
    public var current: ThemeData

    public init(_ data: ThemeData = .dark) {
        self.current = data
    }

    /// Apply a new theme configuration
    public func apply(_ newData: ThemeData) {
        self.current = newData
    }

    /// Toggle between dark and light themes
    public func toggle() {
        self.current = current.inverted
    }
}

// MARK: - ThemeManager Factories

extension ThemeManager {
    @MainActor
    public static func dark() -> ThemeManager {
        ThemeManager(.dark)
    }

    @MainActor
    public static func light() -> ThemeManager {
        ThemeManager(.light)
    }
}

// MARK: - Environment Integration

/// Environment key for ThemeData (the immutable, Sendable data)
private struct ThemeDataEnvironmentKey: EnvironmentKey {
    static let defaultValue: ThemeData = .dark
}

extension EnvironmentValues {
    /// The current FlightUI theme data (immutable, Sendable)
    public var theme: ThemeData {
        get { self[ThemeDataEnvironmentKey.self] }
        set { self[ThemeDataEnvironmentKey.self] = newValue }
    }
}

// MARK: - View Extensions

extension View {
    /// Applies FlightUI theme data to this view hierarchy
    public func flightTheme(_ data: ThemeData) -> some View {
        environment(\.theme, data)
    }

    /// Applies FlightUI theme from a ThemeManager to this view hierarchy
    /// This also observes the manager for changes
    @MainActor
    public func flightTheme(_ manager: ThemeManager) -> some View {
        environment(\.theme, manager.current)
    }
}
