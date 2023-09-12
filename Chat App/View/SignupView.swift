//
//  SignupView.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct SignupView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var appData: AppData
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirm: String = ""
    
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
            CustomTextField(text: $name, placeholder: Text("Nama"))
                .disabled(appData.loading)
            
            CustomTextField(text: $email, placeholder: Text("Email"))
                .disabled(appData.loading)
                .textInputAutocapitalization(.never)
            
            CustomTextField(text: $password, placeholder: Text("Kata Sandi"), secureField: true)
                .disabled(appData.loading)
            
            CustomTextField(text: $passwordConfirm, placeholder: Text("Kata Sandi (Konfirmasi)"), secureField: true)
                .disabled(appData.loading)
        }
    }
    
    var Buttons: some View {
        VStack {
            CustomButton(text: "Daftar") {
                print("🔵Daftar")
                signup()
            }
            .buttonStyle(.borderedProminent)
            .disabled(appData.loading)
            
            Button {
                presentationMode.wrappedValue.dismiss()
            }label: {
                HStack {
                    Text("Sudah Punya Akun ? ")
                        .foregroundColor(.black)
                    Text("Masuk")
                        .foregroundColor(.blue)
                }
            }
            .disabled(appData.loading)
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
        
        appData.toggleLoading()
        let db = Firestore.firestore()
        
        let userCollection = db.collection("users")
        
        let query = userCollection.whereField("email", isEqualTo: email)
        
        query.getDocuments { snapshot, _ in
            print("🔵snapshot: \(String(describing: snapshot))")
            print("🔵document: \(String(describing: snapshot?.documents))")
            guard let documents = snapshot?.documents else {return}
            if !documents.isEmpty {
                print("🔴Error Firabse-Firestore: Account is exist")
                print("🔴Error Firabse-Firestore: \(String(describing: documents))")
                alertTitle = "Gagal Mendaftar"
                alertMsg = "Akun Telah Terdaftar"
                showAlert.toggle()
                appData.toggleLoading()
                return
            }
            
            
            print("🔵Create Data")
            let id = UUID().uuidString
            userCollection.document(id).setData([
                "id": id,
                "name": name,
                "email": email
            ], merge: true) { err in
                if let err = err {
                    print("🔴Error SET DATA: \(err)")
                    alertTitle = "Gagal Mendaftar"
                    alertMsg = "Kesalahan Layanan"
                    showAlert.toggle()
                    appData.toggleLoading()
                    return
                } else {
                    print("🟢Success SET DATA!")
                }
                
                print("🔵Finish Create Data")
                
                print("🔵Create Account Auth")
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
                    appData.toggleLoading()
                }
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
