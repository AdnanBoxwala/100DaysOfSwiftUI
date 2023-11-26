//
//  FriendView.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 01.11.23.
//

import SwiftUI

struct FriendView: View {
    @ObservedObject var database: Database
    var friend: Friend
    
    var body: some View {
        Group {
            if let foundFriend = database.find(with: friend.id) {
                NavigationLink {
                    DetailUserView(database: database, user: foundFriend)
                } label: {
                    Text(friend.name)
                }
            } else {
                Text(friend.name)
            }
        }
    }
}

//#Preview {
//    FriendView()
//}