//
//  Button+Styles.swift
//  FlightUI
//  
//
//  Created by Alan Gorton on 02/12/2022.
//

import SwiftUI

fileprivate let horizontalPadding = 48.0
fileprivate let cornerRadius = 28.0
fileprivate let borderWidth = 3.0

public struct PrimaryButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.title2.bold())
            .foregroundColor(Color(uiColor: .black))
            .padding([.leading, .trailing], horizontalPadding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(Color(uiColor: .systemGreen))
            )
    }
}

public extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: Self {
        return .init()
    }
}

public struct SecondaryButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.title2.bold())
            .foregroundColor(Color(uiColor: .systemGreen))
            .padding([.leading, .trailing], horizontalPadding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(Color(uiColor: .systemGreen), lineWidth: borderWidth)
            )
    }
}

public extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: Self {
        return .init()
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}, label: {
            HStack {
                Image(systemName: "pencil")
                Text("Edit")
            }
        })
        .previewDisplayName("Primary Button with Icon (dark)")
        .buttonStyle(.primary)
        .preferredColorScheme(.dark)

        Button(action: {}, label: {
            HStack {
                Image(systemName: "pencil")
                Text("Edit")
            }
        })
        .previewDisplayName("Primary Button with Icon (light)")
        .buttonStyle(.primary)
        .preferredColorScheme(.light)

        Button("Reset", action: {})
            .previewDisplayName("Secondary Button (dark)")
            .buttonStyle(.secondary)
            .preferredColorScheme(.dark)

        Button("Reset", action: {})
            .previewDisplayName("Secondary Button (light)")
            .buttonStyle(.secondary)
            .preferredColorScheme(.light)
    }
}
