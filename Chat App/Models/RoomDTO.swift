//
//  Room.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 10/09/23.
//

import Foundation

struct RoomDTO: Identifiable, Codable {
    var id: String
    var users: [String]
}

struct Room: Identifiable, Codable, Hashable {
    static func == (lhs: Room, rhs: Room) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String
    var users: [String]
    var partner: User
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
