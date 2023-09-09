//
//  ListUserView.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 09/09/23.
//

import SwiftUI

struct ListUserView: View {
    @State private var searchValue: String = ""
    
    var users = ["Soekarno", "Hatta", "Soeharto", "Jokowi"]
    
    var body: some View {
        VStack {
            HStack {
                CustomTextField(text: $searchValue, placeholder: Text("Cari Pengguna"))
                
                Button {
                    print("Log Out")
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
            .padding()
            
            ScrollView {
                ForEach(users, id: \.self) { user in
                    CustomButton(text: user, alignment: .leading) {
                        print("do Something")
                    } 
                    .buttonStyle(.bordered)
                    
                }
                .padding()
            }
        }
    }
}

struct ListUserView_Previews: PreviewProvider {
    static var previews: some View {
        ListUserView()
    }
}
