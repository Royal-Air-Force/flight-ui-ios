//
//  UIImage+Extensions.swift
//  Kitchen Sink
//
//  Created by Oli Wootton on 04/08/2026.
//

import Foundation
import UIKit

extension UIImage {
    static var appIcon: UIImage? {
        guard let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
              let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
              let lastIcon = iconFiles.last else { return nil }
        return UIImage(named: lastIcon)
    }
}
