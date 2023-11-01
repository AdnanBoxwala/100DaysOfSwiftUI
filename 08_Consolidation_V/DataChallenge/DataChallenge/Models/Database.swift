//
//  User.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 29.10.23.
//

import Foundation

class Database: ObservableObject {
    struct User: Codable, Identifiable {
        var id: String = ""
        var isActive: Bool = false
        var name: String = ""
        var age: Int = 0
        var company: String = ""
        var email: String = ""
        var address: String = ""
        var about: String = ""
        var registered: Date?
        var tags: [String] = []
        var friends: [Friend] = []
    }
    
    @Published var users = [User]()
    
    static func registrationDate(of user: User) -> String {
        if let date = user.registered {
            return date.formatted(date: .abbreviated, time: .omitted)
        } else {
            return "Unknown"
        }
    }
    
    static func tags(for user: User) -> [String] {
        var tags = Set<String>()
        for tag in user.tags {
            tags.insert(tag)
        }
        
        return Array(tags.sorted())
    }
    
    func find(with id: String) -> User? {
        self.users.first(where: {$0.id == id})
    }
}

