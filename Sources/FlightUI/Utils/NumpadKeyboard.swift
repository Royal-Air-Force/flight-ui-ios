//
//  NumpadKeyboard.swift
//  flight-ui-ios
//
//  Created by Appivate 2023
//

import SwiftUI

//struct NumberKeyboardModifier<T: View>: ViewModifier {
//    func body(content: Content) -> some View {
//        (content as? TextField<T>.Type)?.inputView {
//            ZStack {
//
//            }
//            .frame(maxWidth: .infinity)
//            .frame(height: 300)
//        }
//
////        (content as? TextField<TextField.Body>)?.inputView {
////            ZStack {
////
////            }
////            .frame(maxWidth: .infinity)
////            .frame(height: 300)
////        }
//    }
//
//
////    public func _body(configuration: TextField<Self._Label>) -> some View {
////        configuration
////            .inputView {
////                ZStack {
////
////                }
////                .frame(maxWidth: .infinity)
////                .frame(height: 300)
////            }
////    }
//}

extension View {

    
//    public func numberKeyboard() -> some View where Self:View {
//        modifier(NumberKeyboardModifier<Self>())
//    }
}

extension View {
    @ViewBuilder
    public func inputView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        self.background {
            SetNumpadKeyboard(keyboardContent: content())
        }
    }
}

//extension InputField {
//    @ViewBuilder
//    public func numpadKeyboard() -> some View {
//        self.background(SetNumpadKeyboard(keyboardContent: NumpadKeyboard()))
//    }
//}

struct NumpadKeyboard: View {
    
    var body: some View {
        ZStack {
            Color.red
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
    }
    
}

fileprivate struct SetNumpadKeyboard<Content: View>: UIViewRepresentable {
    var keyboardContent: Content
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            if let textFieldContainerView = uiView.superview?.superview {
//                print(textFieldContainerView.subviews)
//                print("----")
//                print("----")
//                print("    ")
                if let textfield = textFieldContainerView.findTextField {
                    print(textfield)
                } else {
                    print("Failed to find text field")
                }
                
                if let textField = textFieldContainerView.findTextField {
                    let hostingController = UIHostingController(rootView: keyboardContent)
                    hostingController.view.frame = .init(origin: .zero, size: hostingController.view.intrinsicContentSize)
                    textField.inputView = hostingController.view
                }
            }
            // This actually is working, it's setting the input view correctly but for some reason superview contains all
            // views on screen so it's only setting it to the first text field, the child of super view doesn't seem to work at all
        }
    }
}

fileprivate extension UIView {
    var allSubViews: [UIView] {
        return subviews.flatMap { [$0] + $0.subviews }
    }
    
    var findTextField: UITextField? {
        iterateAllSubviews(view: self)
        
        return findUITextField(view: self)
        
        
//        if let textField = allSubViews.first(where: { view in
//            view is UITextField
//        }) as? UITextField {
//            return textField
//        }
//        return nil
    }
    
    func iterateAllSubviews(view: UIView) {
        if view is UITextField {
            print("THIS VIEW IS A TEXT FIELD")
        }
        for v in view.subviews {
            if let text = v as? UITextField {
                print("Text Field Found \(text.placeholder)")
            } else {
                iterateAllSubviews(view: v)
            }
            
        }
    }
    
    func findUITextField(view: UIView) -> UITextField? {
        var field: UITextField? = nil
        //print("   ")
        for v in view.subviews {
            
            //print(v.self)
            //print(v.self is UITextField)
            
            
            if let text = v as? UITextField {
                field = text
            }
            if field == nil {
                field = findUITextField(view: v)
            }
        }
        //print("Found text view ")
        return field
    }
}
