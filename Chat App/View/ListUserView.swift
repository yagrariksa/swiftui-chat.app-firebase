//
//  ListUserView.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI

struct ListUserView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var appData: AppData
    @StateObject private var roomDP = RoomDataPresenter()
    
    @State private var searchValue: String = ""
    
    func onAppear() -> Void {
        guard appData.user.id != "" else {
            print("🔴ERROR: User ID is not ready")
            return
        }
        roomDP.fetchChat(appData.user.id)
    }
    
    var users = ["Soekarno", "Hatta", "Soeharto", "Jokowi"]
    
    var body: some View {
        VStack {
            HStack {
                CustomTextField(text: $searchValue, placeholder: Text("Cari Pengguna"))
                
                ButtonLogout
            }
            .padding()
            
            ScrollView {
                ForEach(roomDP.rooms, id: \.self) { room in
                    UserItem(room_id: room.id,user: room.interlocutor)
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear(perform: onAppear)
        .onChange(of: appData.user.id) { _ in
            onAppear()
        }
    }
    
    var ButtonLogout: some View {
        Button {
            print("Log Out")
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            VStack {
                Image(systemName: "power")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.red)
                Text("Keluar")
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
        .padding(.horizontal, 16)
    }
}

struct ListUserView_Previews: PreviewProvider {
    static var previews: some View {
        ListUserView()
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
