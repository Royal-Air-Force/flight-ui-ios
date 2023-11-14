//// NOTE: Temporary file to keep code easily accessible during refactoring

//
// MARK: - Input Field Component -
//
// public struct InputField: View {
//    @Environment (\.validationContext) var context
//    @EnvironmentObject var theme: Theme
//
//    let placeholder: String
//    @Binding var text: String
//    @Binding var status: ValidationStatus
//    let config: InputFieldConfiguration
//    @State private var isNotEditing = true
//    var textBinding: Binding<String> { Binding(get: { format(text) }, set: { text = format($0) }) }
//
//    public init(_ placeholder: String,
//                text: Binding<String>,
//                status: Binding<ValidationStatus> = .constant(.valid),
//                configuration: InputFieldConfiguration = .default) {
//        self.placeholder = placeholder
//        self._text = text
//        self._status = status
//        self.config = configuration
//    }
//
//    public var body: some View {
//        Group {
//            switch config.options.contains(.useThemeStyling) {
//            case true:
//                DebouncedTextField(placeholder, text: textBinding, onEditingChanged: onEditingChanged, debounceTime: config.debounceDuration.rawValue)
//                    .font(config.typography)
//                    // .typography(config.typography, staticText: config.options.contains(.staticText), status: $status)
//                    .padding()
//                    .background(theme.textFieldBackground)
//                    .frame(width: config.size.width(theme: theme), height: theme.textFieldHeight)
//                    .cornerRadius(theme.textFieldCornerRadius)
//                    .multilineTextAlignment(config.alignment)
//                    .keyboardType(keyboardType)
//                    .onChange(of: text, perform: onChangeText)
//                    .disabled(config.options.contains(.staticText))
//                    .overlay(
//                        RoundedRectangle(cornerRadius: borderCornerRadius, style: .continuous)
//                        .strokeBorder(borderColor, lineWidth: borderWidth)
//                    )
//            case false:
//                DebouncedTextField(placeholder, text: textBinding, onEditingChanged: onEditingChanged, debounceTime: config.debounceDuration.rawValue)
//                    .font(config.typography)
////                    .typography(config.typography, staticText: config.options.contains(.staticText), status: $status)
//                    .padding()
//                    .frame(width: config.size.width(theme: theme), height: theme.textFieldHeight)
//                    .multilineTextAlignment(config.alignment)
//                    .keyboardType(keyboardType)
//                    .onChange(of: text, perform: onChangeText)
//                    .disabled(config.options.contains(.staticText))
//                    .overlay(
//                        RoundedRectangle(cornerRadius: borderCornerRadius, style: .continuous)
//                            .strokeBorder(borderColor, lineWidth: borderWidth)
//                    )
//            }
//        }
//        .overlay {
//            if context.status != .valid {
//                RoundedRectangle(cornerRadius: theme.radius.medium)
//                    .strokeBorder(overlayColor, lineWidth: theme.staticTextFieldBorderWidth)
//            }
//        }
//        .disabled(config.options.contains(.staticText))
//    }
//
//    private var borderCornerRadius: Double {
//        config.options.contains(.bordered) ? theme.staticTextFieldCornerRadius : 0
//    }
//
//    private var borderColor: Color {
//        config.options.contains(.bordered) ? theme.staticTextBorder : .clear
//    }
//
//    private var borderWidth: Double {
//        config.options.contains(.bordered) ? theme.staticTextFieldBorderWidth : 0
//    }
//
//    private var overlayColor: Color {
//        switch context.status {
//        case .valid:
//            return theme.validationStatusValid
//        case .warning:
//            return theme.validationStatusWarning
//        case .caution:
//            return theme.validationStatusCaution
//        case .advisory:
//            return theme.validationStatusAdvisory
//        }
//    }
//
//    private func onEditingChanged(isEditing: Bool) {
//        isNotEditing = !isEditing
//        guard !isEditing else { return }
//
//        if let validator = context.validator {
//            context.status = validator(text, .committed)
//        }
//    }
//
//    private func onChangeText(value: String) {
//        if let validator = context.validator {
//            context.status = validator(value, .editing)
//        }
//    }
//
//    private func format(_ string: String) -> String {
//        guard isNotEditing,
//              let doubleValue = Double(string),
//              let formattedString = config.formatter?.string(from: NSNumber(value: doubleValue))
//        else { return string }
//        return formattedString
//    }
//
//    private var keyboardType: UIKeyboardType {
//        switch config.valueType {
//        case .decimal:
//            return .decimalPad
//        default:
//            return .default
//        }
//    }
// }
//
// MARK: - Supporting TextField enums -
//
// public enum TextFieldValueType {
//    case text
//    case decimal
// }
//
// public enum TextFieldSize {
//    case small
//    case medium
//    case large
//    case infinity
//
//    func width(theme: Theme) -> CGFloat? {
//        switch self {
//        case .small:
//            return theme.smallTextFieldWidth
//        case .medium:
//            return theme.mediumTextFieldWidth
//        case .large:
//            return theme.largeTextFieldWidth
//        case .infinity:
//            return nil
//        }
//    }
// }
//
// MARK: - Preview Code -
//
// #if DEBUG
//
// struct InputField_Previews: PreviewProvider {
//    @State private static var text = "Hello World"
//    @State private static var staticText = "Hello Static"
//    @State private static var emptyText = ""
//    @State private static var exampleNumber = "100.1234"
//
//    private static let smallConfig: InputFieldConfiguration = .inputFieldConfiguration(size: .small)
//    private static let mediumConfig: InputFieldConfiguration = .inputFieldConfiguration(size: .medium, typography: .title2)
//    private static let largeConfig: InputFieldConfiguration = .inputFieldConfiguration(size: .large)
//    private static let decimalConfig: InputFieldConfiguration = .inputFieldConfiguration(formatter: .decimal(maximumIntegerDigits: 42, maximumFractionDigits: 4))
//    private static let borderedConfig: InputFieldConfiguration = .inputFieldConfiguration(size: .medium,
//                                                                options: [.useThemeStyling, .bordered])
//    private static let borderedStaticConfig: InputFieldConfiguration = .inputFieldConfiguration(options: .all)
//
//    static func fakeValidator(value: String, mode: ValidationMode) -> ValidationStatus { return .warning(message: "") }
//    @State private static var warningStatus: ValidationStatus = .warning(message: "")
//
//    static var previews: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 10) {
//                Group {
//                    InputField("Bordered",
//                               text: $emptyText,
//                               configuration: borderedConfig)
//
//                    InputField("Placeholder",
//                               text: $text,
//                               configuration: borderedConfig)
//
//                    InputField("Placeholder",
//                               text: $staticText,
//                               configuration: borderedStaticConfig)
//
//                    InputField("Placeholder",
//                               text: $staticText,
//                               configuration: borderedStaticConfig)
//
//                }
//                .padding(.horizontal)
//                Group {
//                    InputField("Placeholder",
//                               text: $emptyText,
//                               configuration: smallConfig)
//
//                    InputField("Placeholder",
//                               text: $text,
//                               configuration: smallConfig)
//
//                    InputField("Placeholder",
//                               text: $emptyText,
//                               configuration: mediumConfig)
//
//                    InputField("Placeholder",
//                               text: $text,
//                               configuration: mediumConfig)
//
//                    InputField("Placeholder",
//                               text: $emptyText,
//                               configuration: largeConfig)
//
//                    InputField("Placeholder",
//                               text: $text,
//                               configuration: largeConfig)
//
//                    InputField("Placeholder",
//                               text: $emptyText)
//
//                    InputField("Placeholder",
//                               text: $text)
//
//                    InputField("Placeholder",
//                               text: $exampleNumber,
//                               configuration: decimalConfig)
//
//                    InputField("Placeholder",
//                               text: $exampleNumber,
//                               configuration: decimalConfig)
//                }
//                Divider()
//                Group {
//                    InputField("Bordered Warning",
//                               text: $emptyText,
//                               configuration: borderedConfig)
//                    InputField("Placeholder",
//                               text: $text,
//                               configuration: mediumConfig)
//                    InputField("Placeholder",
//                               text: $text,
//                               configuration: largeConfig)
//
//                }
//                .validated(by: fakeValidator, status: $warningStatus)
//                .padding(.horizontal)
//                Divider()
//                Group {
//                    InputField("",
//                               text: $emptyText,
//                               configuration: smallConfig)
//                    InputField("",
//                               text: $emptyText,
//                               configuration: mediumConfig)
//                    InputField("",
//                               text: $emptyText,
//                               configuration: largeConfig)
//                    InputField("",
//                               text: $emptyText)
//                }
//                Divider()
//                Group {
//                    InputField("Placeholder",
//                               text: $emptyText,
//                               configuration: .inputFieldConfiguration(size: .medium, options: .none))
//                }
//                Divider()
//                Spacer()
//            }
//            .padding(.vertical)
//        }
//        .environmentObject(Theme())
//        .preferredColorScheme(.dark)
//        .previewDisplayName("Input Field variations")
//        .padding()
//    }
// }
//
// #endif

// MARK: Input Message
// import SwiftUI
//
// public struct InputMessage: View {
//    @Environment (\.validationContext) private var context
//    @EnvironmentObject var theme: Theme
//
//    @Binding private var status: ValidationStatus
//
//    private let useBinding: Bool
//
//    public init() {
//        self.useBinding = false
//        self._status = Binding.constant(ValidationStatus.valid)
//    }
//
//    public init(status: Binding<ValidationStatus>) {
//        self.useBinding = true
//        self._status = status
//    }
//
//    public var body: some View {
//        if let message {
//            Text(message)
//                .foregroundColor(messageColor)
//        } else {
//            EmptyView()
//        }
//    }
//    private var message: LocalizedStringKey? {
//        switch nearestStatus {
//        case .valid:
//            return nil
//        case .warning(let message):
//            return message
//        case .caution(let message):
//            return message
//        case .advisory(let message):
//            return message
//        }
//    }
//
//    private var messageColor: Color {
//        switch nearestStatus {
//        case .valid:
//            return theme.validationStatusValid
//        case .warning:
//            return theme.validationStatusWarning
//        case .caution:
//            return theme.validationStatusCaution
//        case .advisory:
//            return theme.validationStatusAdvisory
//        }
//    }
//
//    private var nearestStatus: ValidationStatus {
//        // Prioritise Status passed as an @Binding over any Validation Context
//        if useBinding {
//            return status
//        }
//
//        return context.status
//    }
// }
//
// struct InputMessage_Previews: PreviewProvider {
//    @State static var warningStatus: ValidationStatus = .warning(message: "example Warning message")
//    @State static var cautionStatus: ValidationStatus = .caution(message: "example Caution message")
//    @State static var advisoryStatus: ValidationStatus = .advisory(message: "example Advisory message")
//
//    static var previews: some View {
//        VStack {
//            VStack {
//                InputMessage()
//                    .environment(\.validationContext, ValidationContext(validator: { _, _ in
//                        return ValidationStatus.valid
//                    }, status: $warningStatus))
//                InputMessage()
//                    .environment(\.validationContext, ValidationContext(validator: { _, _ in
//                        return ValidationStatus.valid
//                    }, status: $cautionStatus))
//                InputMessage()
//                    .environment(\.validationContext, ValidationContext(validator: { _, _ in
//                        return ValidationStatus.valid
//                    }, status: $advisoryStatus))
//            }
//            .environmentObject(Theme())
//
//            VStack {
//                InputMessage()
//                    .environment(\.validationContext, ValidationContext(validator: { _, _ in
//                        return ValidationStatus.valid
//                    }, status: $warningStatus))
//                InputMessage()
//                    .environment(\.validationContext, ValidationContext(validator: { _, _ in
//                        return ValidationStatus.valid
//                    }, status: $cautionStatus))
//                InputMessage()
//                    .environment(\.validationContext, ValidationContext(validator: { _, _ in
//                        return ValidationStatus.valid
//                    }, status: $advisoryStatus))
//            }
//            .environmentObject(Theme())
//        }
//    }
// }
//
// import SwiftUI
//
// public struct InputFieldOptionSet: OptionSet {
//    public let rawValue: UInt8
//
//    public static let useThemeStyling = InputFieldOptionSet(rawValue: 1 << 0)
//    public static let bordered = InputFieldOptionSet(rawValue: 1 << 1)
//    public static let staticText = InputFieldOptionSet(rawValue: 1 << 2)
//
//    public static let none = InputFieldOptionSet([])
//    public static let all = InputFieldOptionSet([.useThemeStyling, .bordered, .staticText])
//
//    public init(rawValue: UInt8) {
//        self.rawValue = rawValue
//    }
// }
//
// public struct InputFieldConfiguration {
//
//    public enum DebounceDuration: Double {
//        case `default` = 0.0
//        case small = 0.3
//    }
//
//    let formatter: NumberFormatter?
//    let valueType: TextFieldValueType
//    let size: TextFieldSize
//    let alignment: TextAlignment
//    let typography: Font
//    let debounceDuration: DebounceDuration
//    let options: InputFieldOptionSet
//
//    private init(
//        formatter: NumberFormatter? = nil,
//        valueType: TextFieldValueType = .text,
//        size: TextFieldSize = .infinity,
//        alignment: TextAlignment = .leading,
//        typography: Font = .body,
//        debounceDuration: DebounceDuration = .default,
//        options: InputFieldOptionSet = .useThemeStyling
//    ) {
//        self.formatter = formatter
//        self.valueType = valueType
//        self.size = size
//        self.alignment = alignment
//        self.typography = typography
//        self.debounceDuration = debounceDuration
//        self.options = options
//    }
// }
//
// extension InputFieldConfiguration {
//    public static var `default`: InputFieldConfiguration {
//        return .inputFieldConfiguration(formatter: nil,
//                                        valueType: .text,
//                                        size: .infinity,
//                                        alignment: .leading,
//                                        debounceDuration: .default,
//                                        options: .useThemeStyling)
//    }
//
//    public static func inputFieldConfiguration(
//        formatter: NumberFormatter? = nil,
//        valueType: TextFieldValueType = .text,
//        size: TextFieldSize = .infinity,
//        alignment: TextAlignment = .leading,
//        typography: Font = .body,
//        debounceDuration: DebounceDuration = .default,
//        options: InputFieldOptionSet = .useThemeStyling
//    ) -> InputFieldConfiguration {
//        InputFieldConfiguration(formatter: formatter,
//                                valueType: valueType,
//                                size: size,
//                                alignment: alignment,
//                                typography: typography,
//                                debounceDuration: debounceDuration,
//                                options: options)
//    }
// }
// import SwiftUI
//
// MARK: - Static Text View Modifiers -
//
// public struct StaticTextOptionSet: OptionSet {
//    public let rawValue: UInt8
//
//    public static let background = StaticTextOptionSet(rawValue: 0x1)
//    public static let bordered = StaticTextOptionSet(rawValue: 0x2)
//
//    public static let none = StaticTextOptionSet([])
//    public static let all = StaticTextOptionSet([.background, .bordered])
//
//    public init(rawValue: UInt8) {
//        self.rawValue = rawValue
//    }
// }
//
// public struct StaticTextStyle: ViewModifier {
//    @EnvironmentObject var theme: Theme
//    private let options: StaticTextOptionSet
//    private let size: TextFieldSize
//
//    public init(options: StaticTextOptionSet = .none,
//                size: TextFieldSize = .infinity) {
//        self.options = options
//        self.size = size
//    }
//
//    public func body(content: Content) -> some View {
//        content
//            .padding()
//            .frame(width: size.width(theme: theme), height: theme.textFieldHeight)
//            .background(options.contains(.background) ? theme.staticTextBackground : .clear)
//            .cornerRadius(options.contains(.background) ? theme.staticTextFieldCornerRadius : 0)
//            .background(
//                RoundedRectangle(cornerRadius: options.contains(.bordered) ? theme.staticTextFieldCornerRadius : 0, style: .continuous)
//                    .stroke(options.contains(.bordered) ? theme.staticTextBorder : .clear, lineWidth: theme.staticTextFieldBorderWidth)
//            )
//    }
// }
//
// MARK: - Text View Extensions -
//
// extension Text {
//    public func staticTextStyle<Style: ViewModifier>(_ style: Style) -> some View {
//        ModifiedContent(content: self, modifier: style)
//    }
// }
//
// MARK: - Preview Code -
//
// #if DEBUG
//
// struct StaticText_Previews: PreviewProvider {
//    static let theme: Theme = .dark
//
//    static var previews: some View {
//        VStack(spacing: 32.0) {
//            Text("Plain")
//                .staticTextStyle(StaticTextStyle(options: .none))
//                .fontStyle(theme.font.body)
//
//            Text("Background")
//                .staticTextStyle(StaticTextStyle(options: .background))
//                .fontStyle(theme.font.body)
//
//            Text("Bordered")
//                .staticTextStyle(StaticTextStyle(options: .bordered))
//                .fontStyle(theme.font.body)
//                .fontWeight(.heavy)
//
//            Text("All Options")
//                .foregroundColor(Color(uiColor: .systemRed))
//                .fontWeight(.bold)
//                .staticTextStyle(StaticTextStyle(options: .all))
//                .fontStyle(theme.font.caption1)
//        }
//        .environmentObject(theme)
//        .previewDisplayName("Static Text variations")
//        .preferredColorScheme(.dark)
//        .padding()
//    }
// }
//
// #endif
// import SwiftUI
//
// MARK: - TextField Style Structs & Leading dot initialisers -
//
// public struct TextFieldType: TextFieldStyle {
//    @EnvironmentObject var theme: Theme
//
//    let valueType: TextFieldValueType
//    let size: TextFieldSize
//    let alignment: TextAlignment
//
//    public init(of valueType: TextFieldValueType = .text,
//                size: TextFieldSize = .infinity,
//                alignment: TextAlignment = .leading) {
//        self.valueType = valueType
//        self.size = size
//        self.alignment = alignment
//    }
//
//    // swiftlint:disable identifier_name
//    public func _body(configuration: TextField<Self._Label>) -> some View {
//        configuration
//            .fontStyle(theme.font.body)
//            .padding()
//            .background(theme.textFieldBackground)
//            .frame(width: size.width(theme: theme), height: theme.textFieldHeight)
//            .cornerRadius(theme.textFieldCornerRadius)
//            .multilineTextAlignment(alignment)
//            .keyboardType(keyboardType)
//    }
//    // swiftlint:enable identifier_name
//
//    private var keyboardType: UIKeyboardType {
//        switch valueType {
//        case .decimal:
//            return .decimalPad
//
//        default:
//            return .default
//        }
//    }
// }
//
// public extension TextFieldStyle where Self == TextFieldType {
//    @available(*, deprecated, message: "Use InputField to replace TextFields")
//    static func type(of valueType: TextFieldValueType = .text,
//                     size: TextFieldSize = .infinity,
//                     alignment: TextAlignment = .leading) -> Self {
//        .init(of: valueType, size: size, alignment: alignment)
//    }
// }
//
// MARK: - Preview Code -
//
// #if DEBUG
//
// struct TextFieldViewModifiersContentPreview: PreviewProvider {
//    @State private static var emptyText = ""
//    @State private static var text = "Hello World"
//
//    static var previews: some View {
//        VStack(alignment: .leading) {
//            TextField("Placeholder", text: $emptyText)
//                .textFieldStyle(.type(size: .small))
//
//            TextField("Placeholder", text: $text)
//                .textFieldStyle(.type(size: .small))
//
//            TextField("Placeholder", text: $emptyText)
//                .textFieldStyle(.type(size: .medium))
//
//            TextField("Placeholder", text: $text)
//                .textFieldStyle(.type(size: .medium))
//
//            TextField("Placeholder", text: $text)
//                .textFieldStyle(.type(size: .infinity))
//
//            TextField("Placeholder", text: $text)
//                .textFieldStyle(.type(size: .infinity))
//                .multilineTextAlignment(.trailing)
//
//            Spacer()
//        }
//        .environmentObject(Theme())
//        .preferredColorScheme(.dark)
//        .previewDisplayName("Text Field variations")
//        .padding()
//    }
// }
//
// #endif
