//
//  DetailUserView.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 30.10.23.
//

import SwiftUI

struct DetailUserView: View {
    @ObservedObject var database: Database
    let user: CachedUser
    
    var body: some View {
        VStack {
            List {
                Section {
                    Text("**Age**: \(user.age)")
                    Text("**Email**: \(user.wrappedEmail)")
                    Text("**Address**: \(user.wrappedAddress)")
                    Text("**Company**: \(user.wrappedCompany)")
                    Text("**Registered on**: \(user.wrappedDate)")
                } header: {
                    Text("Personal Details")
                }
                
                Section {
                    Text("\(user.wrappedAbout)")
                } header: {
                    Text("About")
                }
                
                Section {
                    ForEach(user.cachedFriendArray, id: \.serverId) { friend in
                        FriendView(database: database, friend: friend)
                    }
                } header: {
                    Text("Friends")
                }
                
                // TODO: why does this work differently from above code?
//                VStack(alignment: .leading) {
//                    ForEach(user.sortedFriends()) { friend in
//                        FriendView(database: database, friend: friend)
//                    }
//                }
            }
            
            tagView
        }
        .navigationTitle(user.wrappedname)
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
                ForEach(user.wrappedTags, id: \.self) { tag in
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
