//
//  UserDataPresenter.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 10/09/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserDataPresenter: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var users: [User] = []
    
    func fetchUser(_ ignore: String) {
        let userCollection = db.collection("users")
        
        let query = userCollection.whereField("id", notIn: [ignore])
        
        query.getDocuments { querySnapshot, error in
            if error != nil {
                print("UserDP🔴ERROR: \(String(describing: error))")
            }
            
            guard let documents = querySnapshot?.documents else {
                print("UserDP🔴ERROR: No documents found")
                return
            }
            
            self.users = []
            for document in documents {
                do {
                    let user = try document.data(as: User.self)
                    self.users.append(user)
                } catch {
                    print("UserDP🔴ERROR: \(String(describing: error))")
                }
            }
        }
    }
}
