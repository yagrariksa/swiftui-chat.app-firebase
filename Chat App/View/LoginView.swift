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
    
    @State private var email: String = ""
    @State private var password: String = ""
    
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
            CustomTextField(text: $email, placeholder: Text("Email"))
                .disabled(appData.loading)
                .textInputAutocapitalization(.never)
            
            CustomTextField(text: $password, placeholder: Text("Kata Sandi"), secureField: true)
                .disabled(appData.loading)
            Spacer()
            
            Buttons
        }
        .onAppear {
            password = ""
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
                .disabled(appData.loading)
            
            NavigationLink(destination: SignupView()) {
                HStack {
                    Text("Belum Punya Akun ?")
                        .foregroundColor(.black)
                    Text("Daftar")
                        .foregroundColor(.blue)
                }
                
            }
            .disabled(appData.loading)
            .padding(.top, 16)
            
            NavigationLink("", destination: ListRoomView(), isActive: $succesLogin)
        }
    }
    
    func login() {
        guard email != "" || password != "" else {
            print("🔴ERROR")
            return
        }
        appData.toggleLoading()
        Auth.auth().signIn(withEmail: email, password: password) { (result,error) in
            password = ""
            if error != nil {
                print("🔴Error FirebaseAuth : \(String(describing: error))")
                showAlert.toggle()
                appData.toggleLoading()
            }else {
                print("🟢SUCCESS LOGIN:")
                appData.getUserData(email)
                appData.toggleLoading()
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
