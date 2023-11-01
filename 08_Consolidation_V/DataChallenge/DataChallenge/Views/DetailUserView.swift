//
//  DetailUserView.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 30.10.23.
//

import SwiftUI

struct DetailUserView: View {
    @ObservedObject var database: Database
    let user: Database.User
    
    var body: some View {
        VStack {
            List {
                Section {
                    Text("**Age**: \(user.age)")
                    Text("**Email**: \(user.email)")
                    Text("**Address**: \(user.address)")
                    Text("**Company**: \(user.company)")
                    Text("**Registered on**: \(Database.registrationDate(of: user))")
                } header: {
                    Text("Personal Details")
                }
                
                Section {
                    Text("\(user.about)")
                } header: {
                    Text("About")
                }
                
//                Section {
//                    ForEach(user.friends) { friend in
//                        NavigationLink {
//                            Group {
//                                if let friendObj = database.find(with: friend.id) {
//                                    DetailUserView(database: database, user: friendObj)
//                                }
//                            }
//                        } label: {
//                            Text(friend.name)
//                        }
//                    }
//                } header: {
//                    Text("Friends")
//                }
                
                VStack(alignment: .leading) {
                    ForEach(user.friends) { friend in
                        NavigationLink {
                            Group {
                                if let friendObj = database.find(with: friend.id) {
                                    DetailUserView(database: database, user: friendObj)
                                }
                            }
                        } label: {
                            Text(friend.name)
                        }
                    }
                }
            }
            
            tagView
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    var tagView: some View {
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Image(systemName: "tag")
                ForEach(Database.tags(for: user), id: \.self) { tag in
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
