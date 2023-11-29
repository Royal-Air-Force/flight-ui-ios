//
//  ThemeManager.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

public class ThemeManager: ObservableObject {
    @Published public private(set) var current: Theme

    public init(current: Theme = .dark) {
        self.current = current
    }

    public func updateTheme(_ theme: Theme, changeBaseTheme: Bool = true) {
        self.current = theme
        if changeBaseTheme {
            switch theme.baseScheme {
            case .dark:
                UIApplication.shared.setUserInterfaceStyle(.dark)
            default:
                UIApplication.shared.setUserInterfaceStyle(.light)
            }
        }
    }
}
