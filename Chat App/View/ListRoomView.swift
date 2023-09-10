//
//  ListUserView.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI
import FirebaseAuth

struct ListRoomView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var appData: AppData
    @StateObject private var roomDP = RoomDataPresenter()
    
    @State private var searchValue: String = ""
    @State private var showNewChatSheet: Bool = false
    @State private var newChatCandidate: User? = nil
    
    @State private var roomId_forNewChat: String = ""
    @State private var startNewChat: Bool = false
    
    func setChatCandidate(_ user: User) {
        newChatCandidate = user
    }
    
    func onAppear() -> Void {
        guard appData.user.id != "" else {
            print("🔴ERROR: User ID is not ready")
            return
        }
        roomDP.fetchChat(appData.user.id)
    }
    
    func startChat() {
        guard let candidate = newChatCandidate else {
            print("🔴ERROR: There is no candidate")
            return
        }
        
        if let roomId = roomDP.newChat(appData.user.id, candidate) {
            roomId_forNewChat = roomId
            showNewChatSheet.toggle()
            startNewChat.toggle()
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            
            ScrollView {
                ForEach(roomDP.rooms, id: \.self) { room in
                    UserItem(room_id: room.id,user: room.partner)
                    
                }
                .padding()
            }
            
            NavigationLink("newChat", destination: ChatView(room_id: roomId_forNewChat).navigationTitle(newChatCandidate?.name ?? ""), isActive: $startNewChat)
        }
        .navigationBarBackButtonHidden()
        .onAppear(perform: onAppear)
        .onChange(of: appData.user.id) { _ in
            onAppear()
        }
        .sheet(isPresented: $showNewChatSheet, content: {
            SelectUserView(
                dismiss: {
                    showNewChatSheet.toggle()
                },
                newChatCandidate: $newChatCandidate,
                setChatCandidate: setChatCandidate,
                startChat: startChat)
        })
        .toolbar {
            ToolbarItem(id: "leading", placement: .navigationBarLeading) {
                Button {
                    print("NewChat")
                    showNewChatSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 15, height:15)
                        .foregroundColor(.blue)
                    Text("Chat Baru")
                        .foregroundColor(.blue)
                }
                
                
            }
            
            ToolbarItem(id: "trailing", placement: .navigationBarTrailing) {
                Button {
                    do {
                        try Auth.auth().signOut()
                        self.presentationMode.wrappedValue.dismiss()
                    }catch {
                        print("🔴ERROR: \(String(describing: error))")
                    }

                } label: {
                    Image(systemName: "power")
                        .resizable()
                        .frame(width: 15, height:15)
                        .foregroundColor(.red)
                    Text("Keluar")
                        .foregroundColor(.red)
                }
            }
        }
    }
    
}

struct ListRoomView_Previews: PreviewProvider {
    static var previews: some View {
        ListRoomView()
            .environmentObject(AppData())
    }
}

struct UserItem: View {
    
    var room_id: String
    var user: User
    
    var body: some View {
        NavigationLink(destination: ChatView(room_id: room_id).navigationTitle(user.name)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(user.name)
                        .foregroundColor(.black)
                    Text(user.email)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                Spacer()
            }
            .padding()
            .background(Color("textfield_bg"))
            .cornerRadius(8)
            
        }
        .padding(.bottom, 8)
    }
}
