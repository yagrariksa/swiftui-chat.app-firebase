//
//  LoginView.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct LoginView: View {
    
    @EnvironmentObject var appData: AppData
    
    @State private var email: String = "daffa.yagrariksa@gmail.com"
    @State private var password: String = "yagrariksa"
    
    @State private var succesLogin: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("Chat App")
                .font(.largeTitle)
            Text("Masuk")
                .font(.title)
            Spacer()
            CustomTextField(text: $email, placeholder: Text("Username"))
            
            CustomTextField(text: $password, placeholder: Text("Kata Sandi"), secureField: true)
            Spacer()
            
            Buttons
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Kesalahan Saat Masuk"),
                message: Text("Kata Sandi Salah atau Akun Belum Dibuat"),
                dismissButton: .default(Text("OK")) {
                    showAlert.toggle()
                })
        }
        .onChange(of: appData.user.id) { newValue in
            guard newValue != "" else { return }
            succesLogin.toggle()
        }
    }
    
    var Buttons: some View {
        VStack {
            CustomButton(text: "Masuk", action: login)
                .buttonStyle(.borderedProminent)
            
            NavigationLink(destination: SignupView()) {
                HStack {
                    Text("Belum Punya Akun ?")
                        .foregroundColor(.black)
                    Text("Daftar")
                        .foregroundColor(.blue)
                }
                
            }
            .padding(.top, 16)
            
            NavigationLink("", destination: ListUserView(), isActive: $succesLogin)
        }
    }
    
    func login() {
        guard email != "" || password != "" else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (result,error) in
            if error != nil {
                print("🔴Error FirebaseAuth : \(String(describing: error))")
                showAlert.toggle()
            }else {
                print("🟢SUCCESS LOGIN:")
                appData.getUserData(email)
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
