//
//  MenuFieldStyle+Extensions.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

public extension MenuFieldStyle {
    static var `default`: MenuFieldStyle {
        return MenuFieldStyle(.default)
    }

    static var nominal: MenuFieldStyle {
        return MenuFieldStyle(.nominal)
    }

    static var caution: MenuFieldStyle {
        return MenuFieldStyle(.caution)
    }

    static var warning: MenuFieldStyle {
        return MenuFieldStyle(.warning)
    }
}
