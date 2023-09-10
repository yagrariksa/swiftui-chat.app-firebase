//
//  ChatBubble.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI

struct ChatBubble: View {
    @EnvironmentObject var appData: AppData
    
    var message: Message

    func isSender() -> Bool {
        return message.sender == appData.user.id
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
            Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                .padding(.horizontal)
                .foregroundColor(.gray)
                .font(.caption)
        }
        .padding(.top, 8)
        
    }
}
