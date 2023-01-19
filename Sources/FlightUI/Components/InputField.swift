import SwiftUI

// MARK: - Input Field Component -

public struct InputField: View {
    @Environment (\.validationContext) var context
    @EnvironmentObject var theme: Theme
    
    let placeholder: String
    @Binding var text: String
    let valueType: TextFieldValueType
    let size: TextFieldSize
    let alignment: TextAlignment
    let useThemeStyling: Bool
    var formatter: NumberFormatter?
    @State var isNotEditing = false
    private var textBinding: Binding<String> { Binding(
        get: {
            if isNotEditing,
               let formatter,
               let doubleValue = Double(text),
               let formattedString = formatter.string(from: NSNumber(value: doubleValue)) {
                print("TEXT IS", formattedString)
                print("UNDERLYING TEXT IS", text)
//                shouldRunFormatter = false
                return formattedString
            } else {
                print("editing and text is \(_text.wrappedValue)")
                return text
            }
        },
        set: {
            print("SETTING TEXT, TEXT IS", $0)
            self.text = $0 })}

    public init(_ placeholder: String,
                text: Binding<String>,
                formatter: NumberFormatter? = nil,
                of valueType: TextFieldValueType = .text,
                size: TextFieldSize = .infinity,
                alignment: TextAlignment = .leading,
                useThemeStyling: Bool = true) {
        self.placeholder = placeholder
        self._text = text
        self.formatter = formatter
        self.valueType = valueType
        self.size = size
        self.alignment = alignment
        self.useThemeStyling = useThemeStyling
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            switch useThemeStyling {
            case true:
                TextField("", text: textBinding, onEditingChanged: onEditingChanged)
                    .typography(.input)
                    .padding()
                    .background(theme.textFieldBackground)
                    .frame(width: size.width(theme: theme), height: theme.textFieldHeight)
                    .cornerRadius(theme.textFieldCornerRadius)
                    .multilineTextAlignment(alignment)
                    .keyboardType(keyboardType)
                    .onChange(of: text, perform: onChangeText)
            case false:
                TextField("", text: textBinding, onEditingChanged: onEditingChanged)
                    .typography(.input)
                    .padding()
                    .frame(width: size.width(theme: theme), height: theme.textFieldHeight)
                    .multilineTextAlignment(alignment)
                    .keyboardType(keyboardType)
                    .onChange(of: text, perform: onChangeText)
            }
            if text.isEmpty {
                Text(placeholder)
                    .typography(.emptyField)
                    .padding(.leading)
                    .allowsHitTesting(false)
            }
        }
    }

    func onEditingChanged(isEditing: Bool) {
        isNotEditing = !isEditing
        guard !isEditing else { return }

        if let validator = context.validator {
            context.status = validator(text, .committed)
        }
    }

    func onChangeText(value: String) {
        if let validator = context.validator {
            context.status = validator(value, .editing)
        }
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

// MARK: - Supporting TextField enums -

public enum TextFieldValueType {
    case text
    case decimal
}

public enum TextFieldSize {
    case small
    case medium
    case infinity
    
    func width(theme: Theme) -> CGFloat? {
        switch self {
        case.small:
            return theme.smallTextFieldWidth
        case.medium:
            return theme.mediumTextFieldWidth
        case .infinity:
            return nil
        }
    }
}

// MARK: - Preview Code -

#if DEBUG

struct InputField_Previews: PreviewProvider {
    @State private static var text = "Hello World"
    @State private static var emptyText = ""
    @State private static var exampleNumber = "100.1234"

    static var previews: some View {
        VStack(alignment: .leading, spacing: 10) {
            Group {
                InputField("Placeholder",
                           text: $emptyText,
                           size: .small)
                
                InputField("Placeholder",
                           text: $text,
                           size: .small)

                InputField("Placeholder",
                           text: $emptyText,
                           size: .medium)
                
                InputField("Placeholder",
                           text: $text,
                           size: .medium)
                
                InputField("Placeholder",
                           text: $emptyText,
                           size: .infinity)
                
                InputField("Placeholder",
                           text: $text,
                           size: .infinity)

                InputField("Placeholder",
                           text: $exampleNumber,
                           formatter: .decimal(maximumIntegerDigits: 42),
                           size: .infinity)
            }
            Divider()
            Group {
                InputField("",
                           text: $emptyText,
                           size: .small)
                InputField("",
                           text: $emptyText,
                           size: .medium)
                InputField("",
                           text: $emptyText,
                           size: .infinity)
            }
            Divider()
            Group {
                InputField("Placeholder",
                           text: $emptyText,
                           size: .medium,
                           useThemeStyling: false)
            }
            Divider()
            Spacer()
        }
        .environmentObject(Theme())
        .preferredColorScheme(.dark)
        .previewDisplayName("Input Field variations")
        .padding()
    }
}

#endif
