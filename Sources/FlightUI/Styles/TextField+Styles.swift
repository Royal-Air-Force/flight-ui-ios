import SwiftUI

fileprivate let smallFieldWidth = 84.0
fileprivate let mediumFieldWidth = 146.0
fileprivate let fieldCornerRadius = 5.0

public enum TextFieldValueType {
    case text
    case decimal
}

public enum TextFieldSize{
    case small
    case medium
    case infinity

    var width: Double {
        switch self {
        case.small:
            return smallFieldWidth

        case.medium:
            return mediumFieldWidth

        case .infinity:
            return Double.infinity
        }
    }
}

public struct TextFieldType: TextFieldStyle {
    let valueType: TextFieldValueType
    let size: TextFieldSize
    let alignment: TextAlignment

    public init(of valueType: TextFieldValueType = .text, size: TextFieldSize = .infinity, alignment: TextAlignment = .leading) {
        self.valueType = valueType
        self.size = size
        self.alignment = alignment
    }

    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .fontWeight(.bold)
            .padding()
            .background(Color.neutralDarkGray)
            .foregroundColor(Color.neutralBlue)
            .frame(width: size.width)
            .cornerRadius(fieldCornerRadius)
            .multilineTextAlignment(alignment)
            .keyboardType(keyboardType)
    }

    private var keyboardType: UIKeyboardType {
        switch valueType {
        case .decimal:
            return .decimalPad

        default:
            return .default
        }
    }
}

public extension TextFieldStyle where Self == TextFieldType {
    static func type(of valueType: TextFieldValueType = .text, size: TextFieldSize = .infinity, alignment: TextAlignment = .leading) -> Self {
        .init(of: valueType, size: size, alignment: alignment)
    }
}

struct TextFieldViewModifiers_ContentPreview: PreviewProvider {
    @State private static var emptyText = ""
    @State private static var text = "Hello World"

    static var previews: some View {
        VStack(alignment: .leading) {
            TextField("Placeholder", text: $emptyText)
                .textFieldStyle(.type(size: .small))

            TextField("Placeholder", text: $text)
                .textFieldStyle(.type(size: .small))

            TextField("Placeholder", text: $emptyText)
                .textFieldStyle(.type(size: .medium))

            TextField("Placeholder", text: $text)
                .textFieldStyle(.type(size: .medium))

            TextField("Placeholder", text: $text)
                .textFieldStyle(.type(size: .infinity))

            TextField("Placeholder", text: $text)
                .textFieldStyle(.type(size: .infinity))
                .multilineTextAlignment(.trailing)

            Spacer()
        }
        .preferredColorScheme(.dark)
        .previewDisplayName("Text Field variations")
        .padding()
    }
}
