//
//  ThemeButtons.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

public class ThemeButtons {
    @Published public var filled: FilledButtonStyle
    @Published public var filledIcon: FilledIconButtonStyle
    @Published public var tonal: TonalButtonStyle
    @Published public var tonalIcon: TonalIconButtonStyle
    @Published public var outline: OutlineButtonStyle
    @Published public var outlineIcon: OutlineIconButtonStyle
    @Published public var text: TextButtonStyle
    @Published public var textIcon: TextIconButtonStyle

    public init(filled: FilledButtonStyle = .filled,
                filledIcon: FilledIconButtonStyle = .filledIcon,
                tonal: TonalButtonStyle = .tonal,
                tonalIcon: TonalIconButtonStyle = .tonalIcon,
                outline: OutlineButtonStyle = .outline,
                outlineIcon: OutlineIconButtonStyle = .outlineIcon,
                text: TextButtonStyle = .text,
                textIcon: TextIconButtonStyle = .textIcon
    ) {
        self.filled = filled
        self.filledIcon = filledIcon
        self.tonal = tonal
        self.tonalIcon = tonalIcon
        self.outline = outline
        self.outlineIcon = outlineIcon
        self.text = text
        self.textIcon = textIcon
    }
}
