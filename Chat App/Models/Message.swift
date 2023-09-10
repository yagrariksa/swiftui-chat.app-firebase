//
//  Message.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import Foundation

struct Message: Identifiable, Codable, Hashable {
    
    var id: String
    var sender: String
    var text: String
    var timestamp: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
