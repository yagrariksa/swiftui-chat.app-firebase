//
//  ChatBubble.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI

struct ChatBubble: View {
    var text: String
    var me: Bool = false
    
    var body: some View {
        HStack {
            if me {
                Spacer(minLength: 48)
            }
            Text(text)
                .padding()
                .foregroundColor(.white)
                .background(me ? .blue : .gray)
                .cornerRadius(16)
            if !me {
                Spacer(minLength: 48)
            }
        }
        .padding(.top, 16)
        
        
    }
}
