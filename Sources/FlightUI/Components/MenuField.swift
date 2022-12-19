import SwiftUI

public struct MenuField<SelectionType: CustomStringConvertible & Hashable>: View {
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
                    .typography(selection == nil ? .emptyField : .input)
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

struct MenuField_Previews: PreviewProvider {
    @State static var selection: String?
    @State static var selectionEmpty: String? = ""
    static let options = ["Thor", "Iron Man", "Captain America"]
    
    static var previews: some View {
        
        VStack {
            MenuField(selection: $selection,
                      options: options)
            
            MenuField(selection: $selection,
                      options: options,
                      placeholder: "Custom Placeholder Text")
            
            MenuField(selection: $selectionEmpty,
                      options: options)
            
        }
        .padding()
        .environmentObject(Theme())
    }
}
