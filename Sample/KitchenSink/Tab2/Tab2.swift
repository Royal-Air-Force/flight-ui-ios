import SwiftUI
import FlightUI

struct Tab2: View {
    @EnvironmentObject var theme: Theme
    @StateObject private var viewModel = ViewModel()

    let exampleText = " How vexingly quick daft zebras jump!"

    var body: some View {
        VStack {
            tabHeader
                .padding([.top, .bottom], theme.large)

            headingsText
                .padding([.bottom], theme.large)

            inputsAndResults
                .padding([.bottom], theme.large)

            titleText
                .padding([.bottom], theme.large)

            contentText
                .padding([.bottom], theme.medium)

            captionsText
                .padding([.bottom], theme.medium)

            Spacer()
        }
        .padding([.leading, .trailing], theme.xxlarge)
        .background(Color.flightBlack)
    }

    @ViewBuilder
    var tabHeader: some View {
        HStack {
            Text("Typography")
                .typography(.h1)
            Spacer()
        }
    }

    @ViewBuilder
    var titleText: some View {
        HStack {
            Text("Large Title")
                .font(.largeTitle)
            Spacer()
        }
        HStack {
            Text("Title1")
                .font(.title)
            Spacer()
        }
        HStack {
            Text("Title2")
                .font(.title2)
            Spacer()
        }
        HStack {
            Text("Title3")
                .font(.title3)
            Spacer()
        }
    }

    @ViewBuilder
    var headingsText: some View {
        HStack {
            Text("H1/SF Pro/Bold/28px")
                .typography(.h1)
            Spacer()
        }
        HStack {
            Text("H2/SF Pro/Bold/20px")
                .typography(.h2)
            Spacer()
        }
        HStack {
            Text("H3/SF Pro/Regular/16px")
                .typography(.h3)
            Spacer()
            Text("H3 in Bold will be used for active tabs")
                .typography(.h3)
            Spacer()
        }
    }

    @ViewBuilder
    var inputsAndResults: some View {
        HStack {
            Text("Input/SF Pro/Bold/16px")
                .typography(.input)
            Spacer()
        }
        HStack {
            Text("Result/SF Pro/Bold/16px")
                .typography(.result)
            Spacer()
        }
    }

    @ViewBuilder
    var contentText: some View {
        HStack {
            Text("Headline")
                .font(.headline)
            Spacer()
        }
        HStack {
            Text("Body")
                .font(.body)
            Spacer()
        }
        HStack {
            Text("Callout")
                .font(.callout)
            Spacer()
        }
        HStack {
            Text("Subhead")
                .font(.subheadline)
            Spacer()
        }
    }

    @ViewBuilder
    var captionsText: some View {
        HStack {
            Text("Footnote" + exampleText)
                .font(.footnote)
            Spacer()
        }
        HStack {
            Text("Caption 1" + exampleText)
                .font(.caption)
            Spacer()
        }
        HStack {
            Text("Caption 2" + exampleText)
                .font(.caption2)
            Spacer()
        }
    }
}

struct Tab2_Previews: PreviewProvider {
    static var previews: some View {
        Tab2()
            .environmentObject(Theme())
    }
}
