//
//  ListUserView.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI

struct ListUserView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var searchValue: String = ""
    
    var users = ["Soekarno", "Hatta", "Soeharto", "Jokowi"]
    
    var body: some View {
        VStack {
            HStack {
                CustomTextField(text: $searchValue, placeholder: Text("Cari Pengguna"))
                
                ButtonLogout
            }
            .padding()
            
            ScrollView {
                ForEach(users, id: \.self) { user in
                    UserItem(user: User(id: "123", name: user, username: user))
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden()
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
    
    var user: User
    
    var body: some View {
        NavigationLink(destination: ChatView()) {
            HStack {
                VStack(alignment: .leading) {
                    Text(user.name)
                        .foregroundColor(.black)
                    Text(user.username)
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
