//
//  DetailUserView.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 30.10.23.
//

import SwiftUI

struct DetailUserView: View {
    @ObservedObject var database: Database
    let user: User
    
    var body: some View {
        VStack {
            List {
                Section {
                    Text("**Age**: \(user.age)")
                    Text("**Email**: \(user.email)")
                    Text("**Address**: \(user.address)")
                    Text("**Company**: \(user.company)")
                    Text("**Registered on**: \(user.registrationDate)")
                } header: {
                    Text("Personal Details")
                }
                
                Section {
                    Text("\(user.about)")
                } header: {
                    Text("About")
                }
                
                Section {
                    ForEach(user.sortedFriends()) { friend in
                        FriendView(database: database, friend: friend)
                    }
                } header: {
                    Text("Friends")
                }
                
                // TODO: why does this work differently from above code?
//                VStack(alignment: .leading) {
//                    ForEach(user.friends) { friend in
//                        FriendView(database: database, friend: friend)
//                    }
//                }
            }
            
            tagView
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    ContentView(database: database)
                } label: {
                    Image(systemName: "house")
                }

            }
        }
    }
    
    var tagView: some View {
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Image(systemName: "tag")
                ForEach(user.uniqueTags, id: \.self) { tag in
                    Text(tag)
                        .padding(5)
                        .background(.secondary)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    DetailUserView(user: Database.User())
//}
