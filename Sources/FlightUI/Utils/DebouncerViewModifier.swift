import SwiftUI
import Combine

struct DebounceViewModifier<Value>: ViewModifier where Value: Equatable {

    let trigger: Value
    let action: (Value) -> Void
    let sleep: @Sendable () async throws -> Void

    @State private var debounceTask: Task<Void, Never>?

    func body(content: Content) -> some View {
        content.onChange(of: trigger) { value in
            debounceTask?.cancel()
            debounceTask = Task {
                do { try await sleep() } catch { return }
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
        self.modifier(DebounceViewModifier(trigger: value, action: action) {
            try await Task.sleep(for: duration)
        })
    }
}
