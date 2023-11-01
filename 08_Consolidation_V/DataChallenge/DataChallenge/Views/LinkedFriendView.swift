//
//  LinkedFriendView.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 01.11.23.
//

import SwiftUI

struct LinkedFriendView: View {
    @ObservedObject var database: Database
    var friend: Database.User
    
    var body: some View {
        NavigationLink {
            DetailUserView(database: database, user: friend)
        } label: {
            VStack {
                Text(friend.name)
                Text(friend.email)
            }
        }

    }
}

//#Preview {
//    LinkedFriendView()
//}
