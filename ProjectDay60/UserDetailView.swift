//
//  UserDetailView.swift
//  ProjectDay60
//
//  Created by Rodrigo on 10-08-24.
//

import SwiftUI

struct UserDetailView: View {
    var user: User
    
    var body: some View {
        ScrollView {
            VStack {
                Text(user.name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Text(user.about)
                    .padding()
            }
            .padding(.bottom, 10)
            
            Section("Personal Info"){
                VStack(alignment: .leading) {
                    Text("Company: \(user.company)")
                    Text("Email: \(user.email)")
                    Text("Address: \(user.address)")
                }
                .padding(.vertical, 5)
            }
            
            VStack() {
                Text("Friends")
                    .padding()
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    let user1 = User(id: UUID(uuidString: "50a48fa3-2c0f-4397-ac50-64da464f9954")!, isActive: false, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna", registered: Date.now, tags: [
        "cillum",
        "consequat",
        "deserunt"], friends:[Friend(id: UUID(uuidString: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0")!, name: "Hawkins Patel")])
    
    return UserDetailView(user: user1)
}
