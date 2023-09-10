//
//  SelectUserView.swift
//  Chat App
//
//  Created by Daffa Yagrariksa on 10/09/23.
//

import SwiftUI

struct SelectUserView: View {
    @EnvironmentObject var appData: AppData
    @StateObject private var userDP = UserDataPresenter()
    
    var dismiss: () -> Void
    @Binding var newChatCandidate: User?
    var setChatCandidate: (_ user: User) -> Void
    var startChat: () -> Void
    
    func onAppear() {
        userDP.fetchUser(appData.user.id)
    }
    
    var body: some View {
        NavigationView {
            List(userDP.users, id: \.id) { user in
                Button {
                    setChatCandidate(user)
                } label: {
                    HStack {
                        Text(user.name)
                        Spacer()
                        if newChatCandidate?.id == user.id {
                            Image(systemName: "checkmark")
                        }
                    }
                    
                }
            }
            .onAppear(perform: onAppear)
            .navigationTitle("Pilih Orang")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(id: "Mulai", placement: .navigationBarTrailing) {
                    Button {
                        startChat()
                    } label: {
                        Text("Mulai Chat")
                    }
                    .disabled(newChatCandidate == nil)
                    
                }
                
                ToolbarItem(id: "Batal", placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Batal")
                            .foregroundColor(.red)
                    }
                    
                }
                
            }
        }
    }
}

struct SelectUserView_Previews: PreviewProvider {
    static var previews: some View {
        SelectUserView(
            dismiss: {
                print("dismiss")
            },
            newChatCandidate: .constant(User(id: "123", name: "Abah", email: "abah")))
        { user in
            print("user")
        } startChat: {
            print("start Chat")
        }
    }
}
