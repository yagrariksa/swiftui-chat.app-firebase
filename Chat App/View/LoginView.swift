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
            NavigationLink(destination: ListUserView()) {
                HStack {
                    Spacer()
                    Text("Masuk")
                    Spacer()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            
            NavigationLink(destination: SignupView()) {
                HStack {
                    Text("Belum Punya Akun ?")
                        .foregroundColor(.black)
                    Text("Daftar")
                        .foregroundColor(.blue)
                }
                
            }
            .padding(.top, 16)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
