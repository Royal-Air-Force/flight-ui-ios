import SwiftUI

public class ThemePadding {
    @Published public var grid0_5x: CGFloat
    @Published public var grid1x: CGFloat
    @Published public var grid1_5x: CGFloat
    @Published public var grid2x: CGFloat
    @Published public var grid3x: CGFloat
    @Published public var grid4x: CGFloat
    @Published public var grid5x: CGFloat
    @Published public var grid6x: CGFloat
    @Published public var grid7x: CGFloat
    @Published public var grid8x: CGFloat
    @Published public var grid9x: CGFloat
    @Published public var grid10x: CGFloat
    
    public init(grid0_5x: CGFloat = 4,
                grid1x: CGFloat = 8,
                grid1_5x: CGFloat = 12,
                grid2x: CGFloat = 16,
                grid3x: CGFloat = 24,
                grid4x: CGFloat = 32,
                grid5x: CGFloat = 40,
                grid6x: CGFloat = 48,
                grid7x: CGFloat = 56,
                grid8x: CGFloat = 64,
                grid9x: CGFloat = 72,
                grid10x: CGFloat = 80
    ) {
        self.grid0_5x = grid0_5x
        self.grid1x = grid1x
        self.grid1_5x = grid1_5x
        self.grid2x = grid2x
        self.grid3x = grid3x
        self.grid4x = grid4x
        self.grid5x = grid5x
        self.grid6x = grid6x
        self.grid7x = grid7x
        self.grid8x = grid8x
        self.grid9x = grid9x
        self.grid10x = grid10x
    }
}
