import SwiftUI

// MARK: - Input Field Component -

public struct InputField: View {
    @Environment (\.validationContext) var context
    @EnvironmentObject var theme: Theme

    let placeholder: String
    @Binding var text: String
    @Binding var status: ValidationStatus
    let config: InputFieldConfiguration
    @State private var isNotEditing = true
    var textBinding: Binding<String> { Binding(get: { format(text) }, set: { text = format($0) }) }

    public init(_ placeholder: String,
                text: Binding<String>,
                status: Binding<ValidationStatus> = .constant(.valid),
                configuration: InputFieldConfiguration = .default) {
        self.placeholder = placeholder
        self._text = text
        self._status = status
        self.config = configuration
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            switch config.options.contains(.useThemeStyling) {
            case true:
                TextField("", text: textBinding, onEditingChanged: onEditingChanged)
                    .typography(config.typography, staticText: config.options.contains(.staticText), status: $status)
                    .padding()
                    .background(theme.textFieldBackground)
                    .frame(width: config.size.width(theme: theme), height: theme.textFieldHeight)
                    .cornerRadius(theme.textFieldCornerRadius)
                    .multilineTextAlignment(config.alignment)
                    .keyboardType(keyboardType)
                    .onChange(of: text, perform: onChangeText)
                    .disabled(config.options.contains(.staticText))
                    .when(config.options.contains(.bordered)) { view in
                        view
                            .background(
                                RoundedRectangle(cornerRadius: theme.staticTextFieldCornerRadius, style: .continuous)
                                    .stroke(theme.staticTextBorder, lineWidth: theme.staticTextFieldBorderWidth)
                            )
                    }
            case false:
                TextField("", text: textBinding, onEditingChanged: onEditingChanged)
                    .typography(config.typography, staticText: config.options.contains(.staticText), status: $status)
                    .padding()
                    .frame(width: config.size.width(theme: theme), height: theme.textFieldHeight)
                    .multilineTextAlignment(config.alignment)
                    .keyboardType(keyboardType)
                    .onChange(of: text, perform: onChangeText)
                    .disabled(config.options.contains(.staticText))
                    .when(config.options.contains(.bordered)) { view in
                        view
                            .background(
                                RoundedRectangle(cornerRadius: theme.staticTextFieldCornerRadius, style: .continuous)
                                    .stroke(theme.staticTextBorder, lineWidth: theme.staticTextFieldBorderWidth)
                            )
                    }
            }
            if text.isEmpty {
                Text(placeholder)
                    .typography(.emptyField)
                    .padding(.leading)
                    .allowsHitTesting(false)
                    .disabled(config.options.contains(.staticText))
            }
        }
    }

    private func onEditingChanged(isEditing: Bool) {
        isNotEditing = !isEditing
        guard !isEditing else { return }

        if let validator = context.validator {
            context.status = validator(text, .committed)
        }
    }

    private func onChangeText(value: String) {
        if let validator = context.validator {
            context.status = validator(value, .editing)
        }
    }

    private func format(_ string: String) -> String {
        guard isNotEditing,
              let doubleValue = Double(string),
              let formattedString = config.formatter?.string(from: NSNumber(value: doubleValue))
        else { return string }
        return formattedString
    }

    private var keyboardType: UIKeyboardType {
        switch config.valueType {
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
    case large
    case infinity
    
    func width(theme: Theme) -> CGFloat? {
        switch self {
        case .small:
            return theme.smallTextFieldWidth
        case .medium:
            return theme.mediumTextFieldWidth
        case .large:
            return theme.largeTextFieldWidth
        case .infinity:
            return nil
        }
    }
}

// MARK: - Preview Code -

#if DEBUG

struct InputField_Previews: PreviewProvider {
    @State private static var text = "Hello World"
    @State private static var staticText = "Hello Static"
    @State private static var emptyText = ""
    @State private static var exampleNumber = "100.1234"

    private static let smallConfig: InputFieldConfiguration = .inputFieldConfiguration(size: .small)
    private static let mediumConfig: InputFieldConfiguration = .inputFieldConfiguration(size: .medium, typography: .h2)
    private static let largeConfig: InputFieldConfiguration = .inputFieldConfiguration(size: .large)
    private static let decimalConfig: InputFieldConfiguration = .inputFieldConfiguration(formatter: .decimal(maximumIntegerDigits: 42, maximumFractionDigits: 4))
    private static let borderedConfig: InputFieldConfiguration = .inputFieldConfiguration(size: .medium,
                                                                options: [.useThemeStyling, .bordered])
    private static let borderedStaticConfig: InputFieldConfiguration = .inputFieldConfiguration(options: .all)

    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Group {
                    InputField("Bordered",
                               text: $emptyText,
                               configuration: borderedConfig)
                    InputField("Placeholder",
                               text: $text,
                               configuration: borderedConfig)

                    InputField("Placeholder",
                               text: $staticText,
                               configuration: borderedStaticConfig)

                    InputField("Placeholder",
                               text: $staticText,
                               configuration: borderedStaticConfig)


                }
                .padding(.horizontal)
                Group {

                    InputField("Placeholder",
                               text: $emptyText,
                               configuration: smallConfig)

                    InputField("Placeholder",
                               text: $text,
                               configuration: smallConfig)

                    InputField("Placeholder",
                               text: $emptyText,
                               configuration: mediumConfig)

                    InputField("Placeholder",
                               text: $text,
                               configuration: mediumConfig)

                    InputField("Placeholder",
                               text: $emptyText,
                               configuration: largeConfig)

                    InputField("Placeholder",
                               text: $text,
                               configuration: largeConfig)

                    InputField("Placeholder",
                               text: $emptyText)

                    InputField("Placeholder",
                               text: $text)

                    InputField("Placeholder",
                               text: $exampleNumber,
                               configuration: decimalConfig)

                    InputField("Placeholder",
                               text: $exampleNumber,
                               configuration: decimalConfig)
                }
                Divider()
                Group {
                    InputField("",
                               text: $emptyText,
                               configuration: smallConfig)
                    InputField("",
                               text: $emptyText,
                               configuration: mediumConfig)
                    InputField("",
                               text: $emptyText,
                               configuration: largeConfig)
                    InputField("",
                               text: $emptyText)
                }
                Divider()
                Group {
                    InputField("Placeholder",
                               text: $emptyText,
                               configuration: .inputFieldConfiguration(size: .medium, options: .none))
                }
                Divider()
                Spacer()
            }
            .padding(.vertical)
        }
        .environmentObject(Theme())
        .preferredColorScheme(.dark)
        .previewDisplayName("Input Field variations")
        .padding()
    }
}

#endif
