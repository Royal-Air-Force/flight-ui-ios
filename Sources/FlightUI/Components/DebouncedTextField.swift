import SwiftUI
import Combine

struct DebouncedTextField: View {
    @EnvironmentObject private var theme: Theme
    
    private let placeholder: String
    @Binding private var text: String
    private let onEditingChanged: (Bool) -> Void
    @StateObject private var debouncer: TextFieldDebouncer

    public init(_ placeholder: String, text: Binding<String>, onEditingChanged: @escaping (Bool) -> Void, debounceTime: Double = 0.25) {
        self.placeholder = placeholder
        self._text = text
        self.onEditingChanged = onEditingChanged
        self._debouncer = StateObject(wrappedValue: TextFieldDebouncer(initialText: text.wrappedValue, debounceTime: debounceTime))
    }

    var body: some View {
        TextField("", text: $debouncer.rawText, onEditingChanged: onEditingChanged)
            .overlay {
                if debouncer.rawText.isEmpty {
                    HStack {
                        Text(placeholder)
                            .fontStyle(theme.font.body)
                            .allowsHitTesting(false)
                        Spacer()
                    }
                }
            }
            .onChange(of: debouncer.debouncedText) { newText in
                text = newText
            }
            .onChange(of: text) { newValue in
                debouncer.rawText = newValue
            }
    }
}

class TextFieldDebouncer: ObservableObject {
    @Published var debouncedText = ""
    @Published var rawText = ""

    init(initialText: String, debounceTime: Double) {
        self.rawText = initialText
        $rawText
            .debounce(for: .seconds(debounceTime), scheduler: DispatchQueue.main)
            .assign(to: &$debouncedText)
    }

}


#if DEBUG
struct DebouncedTextField_Previews: PreviewProvider {
    @State private static var text = ""

    static var previews: some View {
        VStack {
            DebouncedTextField("", text: $text, onEditingChanged: {_ in})
            DebouncedTextField("Placeholder", text: $text, onEditingChanged: {_ in})
        }
        .environmentObject(Theme())
        .preferredColorScheme(.dark)
        .previewDisplayName("Debounced TextField variations")
        .padding()
    }

}

#endif
