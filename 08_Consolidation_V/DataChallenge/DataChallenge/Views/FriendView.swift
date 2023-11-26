//
//  FriendView.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 01.11.23.
//

import SwiftUI

struct FriendView: View {
    @ObservedObject var database: Database
    var friend: CachedFriend
    
    var body: some View {
        Group {
            if let foundFriend = database.find(with: friend.wrappedServerId) {
                NavigationLink {
                    DetailUserView(database: database, user: foundFriend)
                } label: {
                    Text(friend.wrappedName)
                }
            } else {
                Text(friend.wrappedName)
            }
        }
    }
}

//#Preview {
//    FriendView()
//}
