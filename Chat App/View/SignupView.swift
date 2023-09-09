//
//  SignupView.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
//    @State private var name: String = ""
    @State private var email: String = "afina.indonesia@gmail.com"
    @State private var password: String = "afina"
    @State private var passwordConfirm: String = "afina123"
    
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMsg: String = ""
    
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
        .navigationBarBackButtonHidden()
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMsg))
        }
    }
    
    var Fields: some View {
        VStack {
//            CustomTextField(text: $name, placeholder: Text("Nama"))
            
            CustomTextField(text: $email, placeholder: Text("Email"))
            
            CustomTextField(text: $password, placeholder: Text("Kata Sandi"), secureField: true)
            
            CustomTextField(text: $passwordConfirm, placeholder: Text("Kata Sandi (Konfirmasi)"), secureField: true)
        }
    }
    
    var Buttons: some View {
        VStack {
            CustomButton(text: "Daftar") {
                print("🔵Daftar")
                signup()
                
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                print("Masuk")
                presentationMode.wrappedValue.dismiss()
            }label: {
                HStack {
                    Text("Sudah Punya Akun ? ")
                        .foregroundColor(.black)
                    Text("Masuk")
                        .foregroundColor(.blue)
                }
            }
            .padding(.top, 16)
        }
    }
    
    func signup() {
        guard email != ""
                && password != ""
                && passwordConfirm != ""
                && password == passwordConfirm
        else {
            print("🔴Input Validation Error")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("🔴Error Firabse-Auth: \(String(describing: error))")
                
                alertTitle = "Gagal Mendaftar"
                alertMsg = "Akun Telah Dibuat"
                
            }else{
                print("🟢Success: \(String(describing: result))")
                
                alertTitle = "Berhasil Mendaftar"
                alertMsg = "Mohon Masuk Menggunakan Data Akun yang Barusaja Anda Buat"
                
                presentationMode.wrappedValue.dismiss()
            }
            showAlert.toggle()
        }
                
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
