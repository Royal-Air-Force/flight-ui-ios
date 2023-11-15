import SwiftUI
import Combine

struct DebounceViewModifier<Value>: ViewModifier where Value: Equatable {
    @State private var debounceTask: Task<Void, Never>?

    let observable: Value
    let action: (Value) -> Void
    let delay: @Sendable () async throws -> Void

    func body(content: Content) -> some View {
        content.onChange(of: observable) { value in
            debounceTask?.cancel()
            debounceTask = Task {
                do { try await delay() } catch { return }
                action(value)
            }
        }
    }
}

extension View {
    public func onDebounce<Value>(
        of value: Value,
        duration: Duration,
        perform action: @escaping (_ newValue: Value) -> Void
    ) -> some View where Value: Equatable {
        self.modifier(DebounceViewModifier(observable: value, action: action) {
            try await Task.sleep(for: duration)
        })
    }
}
