//
//  FlightPanel.swift
//  eTanker
//
//  Created by Alan Gorton on 21/11/2022.
//

import SwiftUI

public struct FlightPanel<Content: View>: View {
    @State private var expanded = false

    private let title: String?
    private let expandable: Bool

    private var content: () -> Content

    private let cornerRadius = 16.0
    private let lineWidth = 6.0

    private let panelColor = Color(uiColor: .tertiarySystemBackground)

    public init(title: String? = nil, expandable: Bool = false, @ViewBuilder content: @escaping () -> Content) {

        self.title = title
        self.expandable = expandable
        self.content = content
    }

    public var body: some View {
        panelView
    }

    private var panelView: some View {
        VStack {
            panelHeaderView

            if (showContent) {
                panelContentView
            }
        }
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .strokeBorder(panelColor, lineWidth: lineWidth)
            .background(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous).fill(Color(uiColor: .systemBackground))))
        .onTapGesture {
            guard expandable else { return }

            withAnimation {
                expanded.toggle()
            }
        }
    }

    private var panelHeaderView: some View {
        HStack {
            if let title {
                panelTitleTextView(title)
            }

            Spacer()

            if expandable {
                expandIcon
            }
        }
        .background(panelColor)
        .padding(.bottom, cornerRadius)
        .cornerRadius(cornerRadius)
        .padding(.bottom, -cornerRadius)
        .padding(.top, cornerRadius)
        .cornerRadius(showContent ? 0 : cornerRadius)
        .padding(.top, -cornerRadius)
    }

    private func panelTitleTextView(_ title: String) -> some View {
        Text(title)
            .padding()
            .font(.title)
            .fontDesign(.rounded)
            .fontWeight(.bold)
            .foregroundColor(Color(uiColor: .label))
    }

    private var expandIcon: some View {
        Image(systemName: "chevron.down")
            .font(.title)
            .foregroundColor(Color(uiColor: .label))
            .rotationEffect(.degrees(expanded ? -180.0 : 0.0))
            .padding()
    }

    private var panelContentView: some View {
        content()
            .padding(.top, cornerRadius / 2)
            .padding([.leading, .trailing, .bottom])
    }

    private var showContent: Bool {
        !expandable || expanded
    }
}

struct FlightPanel_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FlightPanel {
                content
            }
            .previewDisplayName("Content Only (dark)")
            .preferredColorScheme(.dark)


            FlightPanel(title: "Preferences") {
                content
            }
            .previewDisplayName("Title")
            .preferredColorScheme(.dark)

            FlightPanel(title: "Preferences", expandable: true) {
                content
            }
            .previewDisplayName("Expandable")
            .preferredColorScheme(.dark)
        }
        .padding()
    }

    private static var content: some View {
        return Text("Content")
            .font(.title)
    }
}
