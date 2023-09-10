//
//  ChatView.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI

struct ChatView: View {
    var room_id: String
    
    @EnvironmentObject var appData: AppData
    @StateObject private var chatDP = ChatDataPresenter()
    
    @State private var message: String = ""
    
    func onAppear() {
        chatDP.fetchChat(room_id)
    }
    
    func sendMessage() {
        guard message != "" else { return }
        chatDP.sendMessage(
            room_id,
            Message(
                id: UUID().uuidString,
                sender: appData.user.id,
                text: message,
                timestamp: Date()
            ))
    }
    
    var body: some View {
        VStack {
            Spacer()
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(chatDP.chats, id: \.id) { message in
                        ChatBubble(message: message)
                    }
                    .padding()
                }
                .background(Color("textfield_bg"))
                .onChange(of: chatDP.last_bubble_id) { newValue in
                    guard newValue != "" else { return }
                    withAnimation {
                        proxy.scrollTo(newValue)
                        message = ""
                    }
                    
                }
            }
            
            
            HStack {
                CustomTextField(text: $message, placeholder: Text("Pesan"))
                Button(action: sendMessage) {
                    Image(systemName: "paperplane")
                }
                .padding(.horizontal, 8)
            }
            .padding()
        }
        .background(.white)
        .onAppear(perform: onAppear)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(room_id: "123")
    }
}
