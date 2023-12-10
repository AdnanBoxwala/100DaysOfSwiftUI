//
//  ContentView.swift
//  BucketList
//
//  Created by Adnan Boxwala on 10.12.23.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        if lhs.firstName == rhs.firstName {
            return lhs.lastName < rhs.lastName
        }
        return lhs.firstName < rhs.firstName
    }
}

struct ContentView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister")
    ].sorted()
    
    var body: some View {
        List(users) { user in
            Text("\(user.firstName) \(user.lastName)")
        }
    }
}

#Preview {
    ContentView()
}
