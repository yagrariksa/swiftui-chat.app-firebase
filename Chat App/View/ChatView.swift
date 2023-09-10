//
//  ChatView.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI

struct ChatView: View {
    var room_id: String
    
    @StateObject private var chatDP = ChatDataPresenter()
    
    @State private var message: String = ""
    
    func onAppear() {
        chatDP.fetchChat(room_id)
    }
    
    var body: some View {
        VStack {
            Spacer()
            ScrollView {
                ForEach(chatDP.chats, id: \.self) { message in
                    ChatBubble(message: message)
                }
                .padding()
            }
            .background(Color("textfield_bg"))
            
            
            HStack {
                CustomTextField(text: $message, placeholder: Text("Pesan"))
                Button {
                    print("Send Message")
                } label: {
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
