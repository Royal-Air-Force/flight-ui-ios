import SwiftUI

public class ThemeSize{
    @Published public var divider: CGFloat
    @Published public var border: CGFloat
    
    @Published public var iconSmall: CGFloat
    @Published public var iconMedium: CGFloat
    @Published public var iconLarge: CGFloat
    
    @Published public var small: CGFloat
    @Published public var medium: CGFloat
    @Published public var large: CGFloat
    @Published public var xLarge: CGFloat
    @Published public var xxLarge: CGFloat
    @Published public var xxxLarge: CGFloat
    
    public init(divider: CGFloat = 1,
                border: CGFloat = 2,
                iconSmall: CGFloat = 16,
                iconMedium: CGFloat = 24,
                iconLarge: CGFloat = 32,
                small: CGFloat = 40,
                medium: CGFloat = 44,
                large: CGFloat = 48,
                xLarge: CGFloat = 56,
                xxLarge: CGFloat = 64,
                xxxLarge: CGFloat = 72
    ) {
        self.divider = divider
        self.border = border
        
        self.iconSmall = iconSmall
        self.iconMedium = iconMedium
        self.iconLarge = iconLarge
        
        self.small = small
        self.medium = medium
        self.large = large
        self.xLarge = xLarge
        self.xxLarge = xxLarge
        self.xxxLarge = xxxLarge
    }
}
