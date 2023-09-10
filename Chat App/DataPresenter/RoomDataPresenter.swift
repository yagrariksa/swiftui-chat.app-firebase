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
    
    @Published var selected_room_id: String? = nil
    
    let db = Firestore.firestore()
    
    func newChat(_ user_id: String,_ partner: User) {
        print("roomDP🔳Finding Room")
        if let room = rooms.first(where: { room in
            return room.partner.id == partner.id
        }) {
            print("roomDP🟢Room Found: \(String(describing: room))")
            selected_room_id = room.id
        }else {
            print("roomDP🔳Room Not Found, Create New Room")
            let roomCollection = db.collection("rooms")
            
            let id = UUID().uuidString
            roomCollection.document(id).setData([
                "id": id,
                "users": [partner.id, user_id],
            ], merge: true) { err in
                if err != nil {
                    print("roomDP🔴ERROR create room")
                }else{
                    self.selected_room_id = id
                }
            }
        }
    }
    
    func fetchChat(_ user_id: String) {
        let roomCollection = db.collection("rooms")
        let userCollection = db.collection("users")
        
        let query = roomCollection.whereField("users", arrayContains: user_id)
        
        query.addSnapshotListener { querySnapshot, error in
            if error != nil {
                print("roomDP🔴ERROR: \(String(describing: error))")
            }
            
            guard let documents = querySnapshot?.documents else {
                print("roomDP🔴ERROR: No documents found")
                return
            }
            self.roomDTOs = []
            self.rooms = []
            
            for document in documents {
                do {
                    let roomDTO = try document.data(as: RoomDTO.self)
                    self.roomDTOs.append(roomDTO)
                    print("RoomDP⚪️room-DTO \(roomDTO)")
                    
                    guard let interpolator = roomDTO.users.first(where: {$0 != user_id}) else {
                        throw RoomDPError.interpolatorNotFound
                        
                    }
                    
                    print("RoomDP⚪️partner \(interpolator)")
                    
                    let query  = userCollection.whereField("id", isEqualTo: interpolator)
                    query.getDocuments { snapshot, error in
                        guard let users = snapshot?.documents else {
                            return
                        }
                        
                        guard let user = users.first else { return }
                        
                        print("RoomDP⚪️firebase: user: \(String(describing: user.data()))")
                        
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
