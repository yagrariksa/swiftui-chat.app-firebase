//
//  ChatDataPresenter.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 10/09/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatDataPresenter: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var chats: [Message] = []
    
    func fetchChat(_ roomId: String) {
        print("ChatDP🔵START fetchChat(\(roomId))")
        let messagesCollection = db.collection("rooms/\(roomId)/messages")
        
        messagesCollection.getDocuments { querySnapshot, error in
            if error != nil {
                print("ChatDP🔴ERROR: \(String(describing: error))")
            }
            
            guard let documents = querySnapshot?.documents else {
                print("ChatDP🔴ERROR: No documents found")
                return
            }
            
            print("ChatDP🔵Found \(documents.count) Bubble Chat")
            
            self.chats = []
            
            for document in documents {
                do {
                    let message = try document.data(as: Message.self)
                    self.chats.append(message)
                }catch {
                    print("ChatDP🔴ERROR: \(String(describing: error))")
                }
            }
            
            print("ChatDP🟢Success Fetch \(self.chats.count) Bubble Chat")
        }
    }
}
