//
//  ScreenHeader.swift
//  eTanker
//
//  Created by Alan Gorton on 28/11/2022.
//

import SwiftUI

public struct ScreenHeader: View {
    let text: String

    public init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        Text(text)
            .font(.largeTitle.bold())
    }
}

struct ScreenHeader_Previews: PreviewProvider {
    static var previews: some View {
        ScreenHeader("Example header")
    }
}
