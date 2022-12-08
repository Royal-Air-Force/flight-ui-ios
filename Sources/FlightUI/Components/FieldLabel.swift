//
//  FieldLabel.swift
//  eTanker
//
//  Created by Alan Gorton on 28/11/2022.
//

import SwiftUI

public struct FieldLabel: View {
    let text: String

    public init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        Text(text)
            .font(.callout)
    }
}

struct FieldLabel_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            FieldLabel("Example label")
        }
        .padding()
        .preferredColorScheme(.dark)
    }
}
