import SwiftUI

public struct OptionalMenuField<SelectionType: CustomStringConvertible & Hashable>: View {
    @EnvironmentObject var theme: Theme
    @Binding var selection: SelectionType?
    var options: [SelectionType]
    let placeholder: String

    public init(selection: Binding<SelectionType?>,
                options: [SelectionType],
                placeholder: String = "Select") {
        self._selection = selection
        self.options = options
        self.placeholder = placeholder
    }

    public var body: some View {
        Menu {
            Picker("", selection: $selection) {
                ForEach(options, id: \.self) { item in
                    Text("\(item.description)").tag(Optional(item))
                }
            }
        } label: {
            HStack {
                Text(selection?.description ?? placeholder)
                    .fontStyle(theme.font.body)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(theme.menuFieldAccent)
                    .fontWeight(.bold)

            }
        }
        .padding()
        .background(theme.menuFieldBackground)
        .frame(height: theme.menuFieldHeight)
        .cornerRadius(theme.menuFieldCornerRadius)
    }
}

public struct MenuField<SelectionType: CustomStringConvertible & Hashable>: View {

    @Environment (\.validationContext) var context
    @EnvironmentObject var theme: Theme
    @Binding var selection: SelectionType
    var options: [SelectionType]

    public init(selection: Binding<SelectionType>,
                options: [SelectionType]) {
        self._selection = selection
        self.options = options
    }

    public var body: some View {
        Menu {
            Picker("", selection: $selection) {
                ForEach(options, id: \.self) { item in
                    Text("\(item.description)").tag(item)
                }
            }
        } label: {
            HStack {
                Text(selection.description)
                    .fontStyle(theme.font.body)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundColor(theme.menuFieldAccent)
                    .fontWeight(.bold)

            }
        }
        .padding()
        .background(theme.menuFieldBackground)
        .frame(height: theme.menuFieldHeight)
        .cornerRadius(theme.menuFieldCornerRadius)
        .overlay {
            if context.status != .valid {
                RoundedRectangle(cornerRadius: theme.radius.medium)
                    .strokeBorder(overlayColor, lineWidth: theme.staticTextFieldBorderWidth)
            }
        }
    }

    private var overlayColor: Color {
        switch context.status {
        case .valid:
            return theme.validationStatusValid
        case .warning:
            return theme.validationStatusWarning
        case .error:
            return theme.validationStatusError
        }
    }
}

struct MenuField_Previews: PreviewProvider {
    @State static var optionalSelection: String?
    @State static var selection: String = "Iron Man"
    static func fakeValidator(value: String, mode: ValidationMode) -> ValidationStatus { return .error(message: "") }
    @State private static var errorStatus: ValidationStatus = .warning(message: "")
    static let options = ["Thor", "Iron Man", "Captain America"]

    static var previews: some View {

        VStack {
            OptionalMenuField(selection: $optionalSelection,
                      options: options)

            OptionalMenuField(selection: $optionalSelection,
                      options: options,
                      placeholder: "Custom Placeholder Text")
            MenuField(selection: $selection, options: options)
            MenuField(selection: $selection, options: options)
                .validated(by: fakeValidator, status: $errorStatus)
        }
        .padding()
        .environmentObject(Theme())
    }
}
