//
//  CustomButton.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI

struct CustomButton: View {
    var text: String
    var alignment: Alignment = .center
    var action: () -> Void
    
    
    var body: some View {
        Button {
            action()
        }label: {
            if alignment != .leading {
                Spacer()
            }
            Text(text)
                .padding(8)
            if alignment != .trailing {
                Spacer()
            }
            
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(text: "Button") {
            print("Something")
        }
    }
}
