//
//  ChatBubble.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI

struct ChatBubble: View {
    var message: Message

    func isSender() -> Bool {
        return message.sender == "me"
    }
    
    var body: some View {
        
        VStack(alignment: isSender() ? .trailing : .leading) {
            HStack {
                if isSender() {
                    Spacer(minLength: 48)
                }
                Text(message.text)
                    .padding()
                    .foregroundColor(.white)
                    .background(isSender() ? .blue : .gray)
                    .cornerRadius(16)
                if !isSender() {
                    Spacer(minLength: 48)
                }
            }
            Text("\(message.timestamps.formatted(.dateTime.hour().minute()))")
                .padding(.horizontal)
                .foregroundColor(.gray)
        }
        .padding(.top, 8)
        
    }
}
