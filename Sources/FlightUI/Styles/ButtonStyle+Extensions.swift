//
//  ButtonStyle+Extensions.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

public extension ButtonStyle where Self == FilledButtonStyle {
    static var filled: Self {
        return .init()
    }
}

public extension ButtonStyle where Self == FilledIconButtonStyle {
    static var filledIcon: Self {
        return .init()
    }
}

public extension ButtonStyle where Self == TonalButtonStyle {
    static var tonal: Self {
        return .init()
    }
}

public extension ButtonStyle where Self == TonalIconButtonStyle {
    static var tonalIcon: Self {
        return .init()
    }
}

public extension ButtonStyle where Self == OutlineButtonStyle {
    static var outline: Self {
        return .init()
    }
}

public extension ButtonStyle where Self == OutlineIconButtonStyle {
    static var outlineIcon: Self {
        return .init()
    }
}

public extension ButtonStyle where Self == TextButtonStyle {
    static var text: Self {
        return .init()
    }
}

public extension ButtonStyle where Self == TextIconButtonStyle {
    static var textIcon: Self {
        return .init()
    }
}

public extension ButtonStyle where Self == CoreButtonStyle {
    static var advisory: Self {
        return .init(coreType: .advisory)
    }

    static var caution: Self {
        return .init(coreType: .caution)
    }

    static var warning: Self {
        return .init(coreType: .warning)
    }
}
