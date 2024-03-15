//
//  Shape+Extensions.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

extension Shape {
    func style<S: ShapeStyle, F: ShapeStyle>(
        withStroke strokeContent: S,
        lineWidth: CGFloat = 1,
        fill fillContent: F
    ) -> some View {
        self.stroke(strokeContent, lineWidth: lineWidth)
            .background(fill(fillContent))
    }
}
