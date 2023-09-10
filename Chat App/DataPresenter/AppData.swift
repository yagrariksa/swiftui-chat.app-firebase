//
//  AppData.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 10/09/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class AppData: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var user: User = User(id: "", name: "", email: "")
    
    func getUserData(_ email: String) -> Bool {
        let usersCollection = db.collection("users")
        
        let query = usersCollection.whereField("email", isEqualTo: email)
        
        var returnal = false
        
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
                returnal = true
            }catch {
                print("🔴ERROR: \(String(describing: error))")
            }
        }
        
        return returnal
    }
}
