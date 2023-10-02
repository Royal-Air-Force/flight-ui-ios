import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }
    
    @ViewBuilder
    func `ifNotNil`<Transform: View, V>(_ optional: V?, transform: (Self, V) -> Transform) -> some View {
        if let unwrapped = optional {
            transform(self, unwrapped)
        } else { self }
    }
}
