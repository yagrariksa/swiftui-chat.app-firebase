//
//  ChatView.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI

struct ChatView: View {
    
    var chats = ["Hello Daffa How Are You Doing", "Haello I am goo d what about you, i heard you have som holidey", "How Are You"]
    
    @State private var message: String = ""
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("Ahmad Dahlan")
                    .font(.title)
                Spacer()
            }
            .padding()
            
            ScrollView {
                ForEach(chats, id: \.self) { text in
                    ChatBubble(text: text,
                               me: Int.random(in: 0...10) < 7 ? true : false)
                    
                }
                .padding(.horizontal)
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
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
