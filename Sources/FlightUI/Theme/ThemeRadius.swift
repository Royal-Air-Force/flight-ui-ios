import SwiftUI

public class ThemeRadius {
    @Published public var small: CGFloat
    @Published public var medium: CGFloat
    @Published public var large: CGFloat

    public init(small: CGFloat = 2,
                medium: CGFloat = 5,
                large: CGFloat = 8
    ) {
        self.small = small
        self.medium = medium
        self.large = large
    }

    public func innerSmall(padding: CGFloat) -> CGFloat {
        return calculateRadius(outerRadius: small, outerPadding: padding)
    }

    public func innerMedium(padding: CGFloat) -> CGFloat {
        return calculateRadius(outerRadius: medium, outerPadding: padding)
    }

    public func innerLarge(padding: CGFloat) -> CGFloat {
        return calculateRadius(outerRadius: large, outerPadding: padding)
    }

    private func calculateRadius(outerRadius: CGFloat, outerPadding: CGFloat) -> CGFloat {
        let radius = outerRadius - (outerPadding / 2)
        if radius < 1 {
            return 1
        } else {
            return radius
        }
    }
}
