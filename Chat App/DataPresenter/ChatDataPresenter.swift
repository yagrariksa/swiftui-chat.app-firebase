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
    @Published var last_bubble_id: String = ""
    
    func fetchChat(_ roomId: String) {
        print("ChatDP🔵START fetchChat(\(roomId))")
        let messagesCollection = db.collection("rooms/\(roomId)/messages")
        
        messagesCollection.addSnapshotListener { querySnapshot, error in
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
            
            if !self.chats.isEmpty {
                self.chats.sort { a, b in
                    a.timestamp < b.timestamp
                }
                
                self.last_bubble_id = self.chats.last!.id
            }
            
            print("ChatDP🟢Success Fetch \(self.chats.count) Bubble Chat")
        }
    }
    
    func sendMessage(_ roomId: String, _ message: Message) {
        let messagesCollection = db.collection("rooms/\(roomId)/messages")
        
        do {
            try messagesCollection.addDocument(from: message)
        }catch {
            print("ChatDP🔴sendMessage: \(String(describing: error))")
        }
    }
}
