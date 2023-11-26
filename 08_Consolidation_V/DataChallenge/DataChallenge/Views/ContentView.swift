//
//  ContentView.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 29.10.23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var users: FetchedResults<CachedUser>
    
    @StateObject var database = Database()
    
    var body: some View {
        NavigationStack {
            List(database.users, id: \.serverId) { user in
                NavigationLink {
                    DetailUserView(database: database, user: user)
                } label: {
                    BasicUserView(name: user.wrappedname, status: user.isActive)
                }
            }
            .padding(.bottom)
            .onAppear {
                if database.users.isEmpty {
                    Task {
                        print("fetching data from server")
                        await database.fetchData(using: moc)
                    }
                }
            }
            .navigationTitle("Users")
            .navigationBarBackButtonHidden()
            .listStyle(.plain)
        }
    }
}

#Preview {
    ContentView()
}
