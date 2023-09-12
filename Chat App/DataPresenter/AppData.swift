//
//  AppData.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 10/09/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AppData: ObservableObject {
    let db = Firestore.firestore()
    
    init() {
        Auth.auth().addStateDidChangeListener { auth, user in
            print("🔔auth: \(String(describing: auth))")
            print("🔔user: \(String(describing: user))")
        }
    }
    
    @Published var user: User = User(id: "", name: "", email: "")
    @Published var loading: Bool = false
    
    func toggleLoading() {
        loading.toggle()
    }
    
    func getUserData(_ email: String) {
        
        
        let usersCollection = db.collection("users")
        
        let query = usersCollection.whereField("email", isEqualTo: email)
        
        query.getDocuments { querySnapshot, error in
            if error != nil {
                print("🔴ERROR: \(String(describing: error))")
            }
            
            guard let documents = querySnapshot?.documents else {
                print("🔴ERROR: No documents found")
                return
            }
            guard documents.count == 1, let document = documents.first else {
                print("🔴ERROR: No documents found")
                return
            }
            
            do {
                self.user = try document.data(as: User.self)
                print("🟢Firestore Result : \(self.user)")
            }catch {
                print("🔴ERROR: \(String(describing: error))")
            }
        }
        
    }
}
