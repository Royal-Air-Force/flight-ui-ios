import SwiftUI

extension Color {
    var uiColor: UIColor { .init(self) }
    typealias RGBA = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    var rgba: RGBA? {
        var (r, g, b, a): RGBA = (0, 0, 0, 0)
        return uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) ? (r, g, b, a) : nil
    }
    var hexaRGB: String? {
        guard let (red, green, blue, _) = rgba else { return nil }
        return String(format: "#%02x%02x%02x",
            Int(red * 255.999999),
            Int(green * 255.999999),
            Int(blue * 255.999999))
    }
    var hexaRGBA: String? {
        guard let (red, green, blue, alpha) = rgba else { return nil }
        return String(format: "#%02x%02x%02x - \(String(format: "%.0f", (alpha * 100)))%%",
            Int(red * 255.999999),
            Int(green * 255.999999),
            Int(blue * 255.999999))
    }
}
