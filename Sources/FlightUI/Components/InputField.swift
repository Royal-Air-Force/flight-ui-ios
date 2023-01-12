import SwiftUI

public struct InputField: View {
    @Environment (\.validationContext) var context
    @EnvironmentObject var theme: Theme
    
    let placeholder: String
    @Binding var text: String
    let valueType: TextFieldValueType
    let size: TextFieldSize
    let alignment: TextAlignment
    let useThemeStyling: Bool
    
    public init(_ placeholder: String,
                text: Binding<String>,
                of valueType: TextFieldValueType = .text,
                size: TextFieldSize = .infinity,
                alignment: TextAlignment = .leading,
                useThemeStyling: Bool = true) {
        self.placeholder = placeholder
        self._text = text
        self.valueType = valueType
        self.size = size
        self.alignment = alignment
        self.useThemeStyling = useThemeStyling
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            switch useThemeStyling {
            case true:
                TextField("", text: $text, onEditingChanged: onEditingChanged)
                    .typography(.input)
                    .padding()
                    .background(theme.textFieldBackground)
                    .frame(width: size.width(theme: theme), height: theme.textFieldHeight)
                    .cornerRadius(theme.textFieldCornerRadius)
                    .multilineTextAlignment(alignment)
                    .keyboardType(keyboardType)
                    .onChange(of: text, perform: onChangeText)
            case false:
                TextField("", text: $text, onEditingChanged: onEditingChanged)
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
        guard !isEditing else { return }

        if let validator = context.validator {
            print("running commited validation")
            context.status = validator(text, .committed)
        }
    }

    func onChangeText(value: String) {
        if let validator = context.validator {
            print("running editing validation")

            context.status = validator(value, .editing)
        } else {
            print("no validator")
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

struct InputField_Previews: PreviewProvider {
    @State private static var text = ""

    static var previews: some View {
        VStack {
            InputField("Placeholder", text: $text)
            InputField("Placeholder No Styling", text: $text, useThemeStyling: false)
        }
        .padding()
        .preferredColorScheme(.dark)
        .environmentObject(Theme())
    }
}
