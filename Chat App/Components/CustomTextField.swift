//
//  CustomTextField.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: Text
    
    var secureField: Bool = false
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    placeholder
                        .opacity(0.5)
                }
                if secureField {
                    SecureField("", text: $text)
                }else{
                    TextField("", text: $text)
                }
                
                
            }
        }
        .padding()
        .background(Color("textfield_bg"))
        .cornerRadius(8)
        
        
    }
}


struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""), placeholder: Text("Placeholder"))
    }
}
