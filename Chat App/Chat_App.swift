//
//  Chat_AppApp.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI
import FirebaseCore

@main
struct Chat_App: App {

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
