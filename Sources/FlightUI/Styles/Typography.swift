import SwiftUI

// MARK: - View Modifier Structs -

struct Header1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .bold))
            .foregroundColor(.ballisticPrimary)
    }
}

struct Header2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.ballisticPrimary)
    }
}

struct Header3: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.ballisticPrimary)
    }
}

struct Input: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.neutralBlue)
    }
}

struct ResultTypography: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.ballisticSecondary)
    }
}

struct ButtonTypography: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.ballisticPrimary)
    }
}

struct Caption: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.ballisticPrimary)
    }
}

struct EmptyField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.neutralLightGray)
    }
}

struct DropDownOptions: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.neutralBlue)
    }
}

// MARK: - View Extention Function -

enum Typography: CaseIterable { case h1, h2, h3, input, result, button, caption, emptyField, dropDownOptions }

extension View {
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
            .previewDisplayName("All Typography (Dark)")
            .preferredColorScheme(.dark)
        
        typographyList
            .previewDisplayName("All Typography (Light)")
            .preferredColorScheme(.light)
    }
}
