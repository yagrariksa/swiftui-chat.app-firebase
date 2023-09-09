//
//  SignupView.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI

struct SignupView: View {
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var passwordConfirm: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Chat App")
                .font(.largeTitle)
            Text("Daftar")
                .font(.title)
            
            Spacer()
            
            Fields
            
            Spacer()
            
            Buttons
        }
        .padding()
    }
    
    var Fields: some View {
        VStack {
            CustomTextField(text: $name, placeholder: Text("Nama"))
            
            CustomTextField(text: $username, placeholder: Text("Username"))
            
            CustomTextField(text: $password, placeholder: Text("Kata Sandi"), secureField: true)
            
            CustomTextField(text: $passwordConfirm, placeholder: Text("Kata Sandi (Konfirmasi)"), secureField: true)
        }
    }
    
    var Buttons: some View {
        VStack {
            CustomButton(text: "Daftar") {
                print("Daftar")
            }
            .buttonStyle(.borderedProminent)
            
            CustomButton(text: "Masuk") {
                print("Masuk")
            }
            .buttonStyle(.bordered)
        }
        .frame(width: .infinity)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
