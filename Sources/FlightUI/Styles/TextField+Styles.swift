import SwiftUI

// MARK: - TextField Style Structs & Leading dot initialisers -

public struct TextFieldType: TextFieldStyle {
    @EnvironmentObject var theme: Theme

    let valueType: TextFieldValueType
    let size: TextFieldSize
    let alignment: TextAlignment

    public init(of valueType: TextFieldValueType = .text,
                size: TextFieldSize = .infinity,
                alignment: TextAlignment = .leading) {
        self.valueType = valueType
        self.size = size
        self.alignment = alignment
    }

    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .fontStyle(theme.font.body)
            .padding()
            .background(theme.textFieldBackground)
            .frame(width: size.width(theme: theme), height: theme.textFieldHeight)
            .cornerRadius(theme.textFieldCornerRadius)
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
    @available(*, deprecated, message: "Use InputField to replace TextFields")
    static func type(of valueType: TextFieldValueType = .text,
                     size: TextFieldSize = .infinity,
                     alignment: TextAlignment = .leading) -> Self {
        .init(of: valueType, size: size, alignment: alignment)
    }
}

// MARK: - Preview Code -

#if DEBUG

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
        .environmentObject(Theme())
        .preferredColorScheme(.dark)
        .previewDisplayName("Text Field variations")
        .padding()
    }
}

#endif
