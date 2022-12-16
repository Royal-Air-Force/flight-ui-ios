import SwiftUI

// MARK: - View Modifier Structs -

public struct Header1: ViewModifier {
    @EnvironmentObject var theme: Theme
    
    public func body(content: Content) -> some View {
        content
            .font(.title.bold())
            .foregroundColor(theme.header)
    }
}

public struct Header2: ViewModifier {
    @EnvironmentObject var theme: Theme
    
    public func body(content: Content) -> some View {
        content
            .font(.title3.bold())
            .foregroundColor(theme.header)
    }
}

public struct Header3: ViewModifier {
    @EnvironmentObject var theme: Theme
    
    public func body(content: Content) -> some View {
        content
            .font(.callout)
            .foregroundColor(theme.header)
    }
}

public struct Input: ViewModifier {
    @EnvironmentObject var theme: Theme
    
    public func body(content: Content) -> some View {
        content
            .font(.callout.bold())
            .foregroundColor(theme.input)
    }
}

public struct ResultTypography: ViewModifier {
    @EnvironmentObject var theme: Theme
    
    public func body(content: Content) -> some View {
        content
            .font(.callout.bold())
            .foregroundColor(theme.result)
    }
}

public struct ButtonTypography: ViewModifier {
    @EnvironmentObject var theme: Theme
    
    public func body(content: Content) -> some View {
        content
            .font(.body.bold())
            .foregroundColor(theme.buttonTypography)
    }
}

public struct Caption: ViewModifier {
    @EnvironmentObject var theme: Theme
    
    public func body(content: Content) -> some View {
        content
            .font(.callout)
            .foregroundColor(theme.caption)
    }
}

public struct EmptyField: ViewModifier {
    @EnvironmentObject var theme: Theme
    
    public func body(content: Content) -> some View {
        content
            .font(.callout)
            .foregroundColor(theme.emptyField)
    }
}

public struct DropDownOptions: ViewModifier {
    @EnvironmentObject var theme: Theme
    
    public func body(content: Content) -> some View {
        content
            .font(.callout)
            .foregroundColor(theme.dropDownOption)
    }
}

// MARK: - View Extention Function -

public enum Typography: CaseIterable { case h1, h2, h3, input, result, button, caption, emptyField, dropDownOptions }

public extension View {
    @ViewBuilder
    func typography(_ typography: Typography) -> some View {
        switch typography {
        case .h1:
            modifier(Header1())
        case .h2:
            modifier(Header2())
        case .h3:
            modifier(Header3())
        case .input:
            modifier(Input())
        case .result:
            modifier(ResultTypography())
        case .button:
            modifier(ButtonTypography())
        case .caption:
            modifier(Caption())
        case .emptyField:
            modifier(EmptyField())
        case .dropDownOptions:
            modifier(DropDownOptions())
        }
    }
}

// MARK: - FilePrivate Preview Code -

#if DEBUG

fileprivate extension Typography {
    var name: String {
        switch self {
        case .h1:
            return "Header 1"
        case .h2:
            return "Header 2"
        case .h3:
            return "Header 3"
        case .input:
            return "Input"
        case .result:
            return "Result"
        case .button:
            return "Button"
        case .caption:
            return "Caption"
        case .emptyField:
            return "Empty Field"
        case .dropDownOptions:
            return "Drop Down Options"
        }
    }
}

struct Typography_Previews: PreviewProvider {
    private static var typographyList: some View {
        NavigationStack {
            List(Typography.allCases, id: \.name) { typography in
                    Text("\(typography.name)")
                    .typography(typography)
                    .padding()
            }
            .navigationTitle("Typography")
        }
    }
    
    static var previews: some View {
        typographyList
            .environmentObject(Theme())
            .previewDisplayName("All Typography")
            .preferredColorScheme(.dark)
    }
}

#endif
