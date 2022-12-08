//
//  File.swift
//  
//
//  Created by Alan Gorton on 08/12/2022.
//

import SwiftUI

extension View {
    @ViewBuilder func when<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
