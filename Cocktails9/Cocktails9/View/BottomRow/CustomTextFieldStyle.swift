import SwiftUI

struct CustomTextFieldStyle: ViewModifier {
    var cornerRadius: CGFloat = 10
    var borderColor: Color = .blue
    var padding: CGFloat = 10
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.vertical, padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 2)
            )
            .padding(.bottom)
    }
}

extension View {
    func customTextFieldStyle(cornerRadius: CGFloat = 10, borderColor: Color = .blue, padding: CGFloat = 10) -> some View {
        self.modifier(CustomTextFieldStyle(cornerRadius: cornerRadius, borderColor: borderColor, padding: padding))
    }
}
