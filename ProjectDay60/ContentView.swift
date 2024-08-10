//
//  ContentView.swift
//  ProjectDay60
//
//  Created by Rodrigo on 10-08-24.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink(value: user) {
                    
                    Text(user.isActive ? "🟢" : "🔴")
                    
                    HStack {
                        VStack(alignment: .leading){
                            Text(user.name)
                            Text("company: \(user.company)")
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 8)
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
            .task {
                await loadUsers()
            }
        }
    }
    
    func loadUsers() async {
        
        if users.count > 0 {
            return
        }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("invalid URL")
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                users = decodedResponse
            }
            
        } catch {
            print("error decoding \(error)")
        }
        
        
    }
}

#Preview {
    ContentView()
}
