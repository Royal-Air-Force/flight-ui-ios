import SwiftUI

// MARK: - View Extensions

extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) } else { self }
    }

    @ViewBuilder
    func `ifNotNil`<Transform: View, V>(_ optional: V?, transform: (Self, V) -> Transform) -> some View {
        if let unwrapped = optional {
            transform(self, unwrapped)
        } else { self }
    }
}

// MARK: - UIApplication Extension

extension UIApplication {
    public func setUserInterfaceStyle(_ style: UIUserInterfaceStyle) {
        let scenes = self.connectedScenes
        guard let scene = scenes.first as? UIWindowScene else { return }
        scene.keyWindow?.overrideUserInterfaceStyle = style
    }
}

// MARK: - Shape Extensions

extension Shape {
    func style<S: ShapeStyle, F: ShapeStyle>(
        withStroke strokeContent: S,
        lineWidth: CGFloat = 1,
        fill fillContent: F
    ) -> some View {
        self.stroke(strokeContent, lineWidth: lineWidth)
            .background(fill(fillContent))
    }
}

// MARK: - Rounded Corner Shape

extension View {
    @ViewBuilder
    public func clipCorners(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
