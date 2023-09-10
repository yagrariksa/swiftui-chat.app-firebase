//
//  UsersDataPresenter.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 10/09/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class RoomDataPresenter: ObservableObject {
    
    private var roomDTOs: [RoomDTO] = []
    @Published var rooms: [Room] = []
    @Published var dummies: [String] = []
    
    let db = Firestore.firestore()
    
    func newChat(_ user_id: String,_ partner: User) -> String? {
        print("roomDP🔳Finding Room")
        if let room = rooms.first(where: { room in
            return room.partner.id == partner.id
        }) {
            print("roomDP🟢Room Found: \(String(describing: room))")
            return room.id
        }else {
            print("roomDP🔳Room Not Found, Create New Room")
            let roomCollection = db.collection("rooms")
            
            do {
                let id = UUID().uuidString
                try roomCollection.addDocument(from: RoomDTO(id: id, users: [partner.id, user_id]))
                print("roomDP🟢Success Create Room: \(id)")
                return id
            } catch {
                print("roomDP🔴ERROR create room")
            }
        }
        
        return nil
    }
    
    func fetchChat(_ user_id: String) {
        let roomCollection = db.collection("rooms")
        let userCollection = db.collection("users")
        
        let query = roomCollection.whereField("users", arrayContains: user_id)
        
        query.addSnapshotListener { querySnapshot, error in
            if error != nil {
                print("🔴ERROR: \(String(describing: error))")
            }
            
            guard let documents = querySnapshot?.documents else {
                print("🔴ERROR: No documents found")
                return
            }
            self.roomDTOs = []
            self.rooms = []
            
            for document in documents {
                do {
                    let roomDTO = try document.data(as: RoomDTO.self)
                    self.roomDTOs.append(roomDTO)
                    // print("RoomDP⚪️room-DTO \(roomDTO)")
                    
                    guard let interpolator = roomDTO.users.first(where: {$0 != user_id}) else {
                        throw RoomDPError.interpolatorNotFound
                        
                    }
                    
                    // print("RoomDP⚪️interpolator \(interpolator)")
                    
                    userCollection.document(interpolator).getDocument { snapshot, error in
                        guard let user = snapshot else {
                            return
                        }
                        
                        // print("RoomDP⚪️firebase: user: \(String(describing: user.data()))")
                        
                        do {
                            let room = Room(id: roomDTO.id, users: roomDTO.users, partner: try user.data(as: User.self))
                            self.rooms.append(room)
                            print("RoomDP🟩\(room)")
                        }catch {
                            print("RoomDP🟥ERROR: \(String(describing: error))")
                        }
                    }
                }catch {
                    print("RoomDP🔴ERROR: \(String(describing: error))")
                }
            }
            
            print("RoomDP🟢Success Fetch Data: \(self.rooms.count) Room Found")
            
            self.dummies = []
            for i in 0...10 {
                self.dummies.append("Data-\(i)")
            }
        }
    }
}

enum RoomDPError: Error {
    case interpolatorNotFound
}
