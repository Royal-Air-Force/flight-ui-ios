import SwiftUI

public class ThemeRadius{
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
        return small - (padding / 2)
    }
    
    public func innerMedium(padding: CGFloat) -> CGFloat {
        return medium - (padding / 2)
    }
    
    public func innerLarge(padding: CGFloat) -> CGFloat {
        return large - (padding / 2)
    }
}
