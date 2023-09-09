//
//  LoginView.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    var body: some View {
        VStack {
            Spacer()
            Text("Chat App")
                .font(.largeTitle)
            Text("Masuk")
                .font(.title)
            Spacer()
            CustomTextField(text: $username, placeholder: Text("Username"))
            
            CustomTextField(text: $password, placeholder: Text("Kata Sandi"), secureField: true)
            Spacer()
            
            Buttons
        }
        .padding()
    }
    
    var Buttons: some View {
        VStack {
            CustomButton(text: "Masuk") {
                print("Masuk")
            }
            .buttonStyle(.borderedProminent)
            
            CustomButton(text: "Daftar") {
                print("Daftar")
            }
            .buttonStyle(.bordered)
        }
        .frame(width: .infinity)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
