//
//  ContentView.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 29.10.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var database = Database()
    
    var body: some View {
        NavigationStack {
            VStack {
                List(database.users) { user in
                    NavigationLink {
                        DetailUserView(database: database, user: user)
                    } label: {
                        BasicUserView(name: user.name, status: user.isActive)
                    }
                }
            }
            .onAppear {
                Task {
                    await fetchData()
                }
            }
            .navigationTitle("Users")
            .listStyle(.plain)
        }
    }
    
    func fetchData() async {
        if !database.users.isEmpty { return }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedDatabase = try? decoder.decode([Database.User].self, from: data) {
                let sortedDatabase = decodedDatabase.sorted {$0.name < $1.name}
                database.users = sortedDatabase
            } else {
                fatalError("Failed to decode data.")
            }
        } catch {
            fatalError("Failed to load data: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
