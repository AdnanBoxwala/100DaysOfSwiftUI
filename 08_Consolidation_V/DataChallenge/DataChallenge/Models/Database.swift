//
//  User.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 29.10.23.
//

import CoreData
import Foundation
import SwiftUI

class Database: ObservableObject {
    @Published var users = [CachedUser]()
    
    func find(with id: String) -> CachedUser? {
        self.users.first { $0.wrappedServerId == id }
    }
    
    func fetchData(using moc: NSManagedObjectContext) async {
        // TODO: Change Fetch Order.
        // First fetch from core data, view is updated using this.
        // Then fetch from server or local file and update cache on main thread.
        print("Fetching start!!")
        await fetchLocalData(using: moc)
        
        await MainActor.run {
            fetchFromCoreData(in: moc)
        }
    }
    
    func fetchServerData(using moc: NSManagedObjectContext) async {
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedDatabase = try? decoder.decode([User].self, from: data) {
                await MainActor.run {
                    updateCache(from: decodedDatabase, using: moc)
                }
            } else {
                fatalError("Failed to decode data.")
            }
        } catch {
            fatalError("Failed to load data: \(error.localizedDescription)")
        }
    }
    
    func fetchLocalData(using moc: NSManagedObjectContext) async {
        print("Fetching local json data")
        let users: [User] = Bundle.main.decode("friendface.json")
        await MainActor.run {
            updateCache(from: users, using: moc)
        }
    }
    
    func updateCache(from downloadedUsers: [User], using moc: NSManagedObjectContext) {
        print("Updating Cache")
        moc.perform {
            for user in downloadedUsers {
                let cachedUser = CachedUser(context: moc)
                cachedUser.about = user.about
                cachedUser.address = user.address
                cachedUser.age = user.age
                cachedUser.company = user.company
                cachedUser.date = user.registered
                cachedUser.email = user.email
                cachedUser.isActive = user.isActive
                cachedUser.name = user.name
                cachedUser.serverId = user.serverId
                cachedUser.tags = user.tags.joined(separator: ",")
                
                for friend in user.friends {
                    let cachedFriend = CachedFriend(context: moc)
                    cachedFriend.serverId = friend.serverId
                    cachedFriend.name = friend.name
                    cachedUser.addToCachedFriend(cachedFriend)
                }
            }
        }
        
        
//        try? moc.save()
//        print("Updated Cache")
    }
    
    func fetchFromCoreData(in moc: NSManagedObjectContext) {
        print("Fetching from core data")
        let request = CachedUser.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CachedUser.name, ascending: true)]
        
        if let users = try? moc.fetch(request) {
            self.users = users
        }
        print("Core data fetch done")
    }
}
