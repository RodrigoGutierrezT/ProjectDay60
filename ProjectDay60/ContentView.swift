//
//  ContentView.swift
//  ProjectDay60
//
//  Created by Rodrigo on 10-08-24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort:[SortDescriptor(\User.name)]) var users: [User]
    
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
            .toolbar {
                ToolbarItem() {
                    Button("Delete all", systemImage: "trash") {
                        do {
                            try modelContext.delete(model: User.self)
                        } catch {
                            print("Failed to delete users")
                        }
                        
                    }
                }
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
                for user in decodedResponse {
                    print(user)
                    modelContext.insert(user)
                }
            }
            
        } catch {
            print("error decoding \(error)")
        }
        
        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        let user1 = User(id: UUID(uuidString: "50a48fa3-2c0f-4397-ac50-64da464f9954")!, isActive: false, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna", registered: Date.now, tags: [
            "cillum",
            "consequat",
            "deserunt"], friends:[Friend(id: UUID(uuidString: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0")!, name: "Hawkins Patel")])
        
        return ContentView()
            .modelContainer(container)
        
    } catch {
        return Text("Failed to create preview \(error.localizedDescription)")
    }
}
