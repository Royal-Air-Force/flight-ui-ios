import SwiftUI

struct InputField: View {
    let placeholder: String

    @Binding var text: String

    @Environment (\.validationContext) var context
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }

    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text, onEditingChanged: onEditingChanged)
                .onChange(of: text, perform: onChangeText)
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
}

struct InputField_Previews: PreviewProvider {
    @State private static var text = ""

    static var previews: some View {
        VStack {
            InputField("Placeholder", text: $text)
        }
        .padding()
        .preferredColorScheme(.dark)
        .environmentObject(Theme())
    }
}
