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
        appData.toggleLoading()
        chatDP.sendMessage(
            room_id,
            Message(
                id: UUID().uuidString,
                sender: appData.user.id,
                text: message,
                timestamp: Date()
            ))
        appData.toggleLoading()
    }
    
    func scroll(_ proxy: ScrollViewProxy) {
        guard let last = chatDP.chats.last else { return }
        withAnimation {
            print("🔶SCROLL!: \(last.id)")
            proxy.scrollTo(last.id)
            message = ""
        }
    }
    
    var body: some View {
        VStack {
            
            if chatDP.chats.count > 0 {
                Spacer()
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(chatDP.chats, id: \.id) { message in
                            ChatBubble(message: message)
                        }
                        .padding()
                        .onAppear {
                            scroll(proxy)
                        }
                        .onChange(of: chatDP.chats.count) { _ in
                            scroll(proxy)
                        }
                    }
                    .background(Color("textfield_bg"))
                }
            }else {
                Spacer()
                EmptyChat
                Spacer()
            }
            
            HStack {
                CustomTextField(text: $message, placeholder: Text("Pesan"))
                    .disabled(appData.loading)
                Button(action: sendMessage) {
                    Image(systemName: "paperplane")
                }
                .disabled(appData.loading)
                .padding(.horizontal, 8)
            }
            .padding()
        }
        .background(.white)
        .onAppear(perform: onAppear)
    }
    
    var EmptyChat: some View {
        VStack {
            Image(systemName: "ellipsis.message")
                .resizable()
                .frame(width: 100, height: 100)
            Text("Mulai Percakapan Anda!")
                .font(.title)
        }
        .foregroundColor(.gray)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(room_id: "123")
    }
}
