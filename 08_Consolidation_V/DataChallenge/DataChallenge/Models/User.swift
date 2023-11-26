//
//  User.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 01.11.23.
//

import Foundation

struct User: Codable {
    enum CodingKeys: String, CodingKey {
        case serverId = "id"
        case isActive = "isActive"
        case name = "name"
        case age = "age"
        case company = "company"
        case email = "email"
        case address = "address"
        case about = "about"
        case registered = "registered"
        case tags = "tags"
        case friends = "friends"
    }
    var serverId: String = ""
    var isActive: Bool = false
    var name: String = ""
    var age: Int16 = 0
    var company: String = ""
    var email: String = ""
    var address: String = ""
    var about: String = ""
    var registered: Date?
    var tags: [String] = []
    var friends: [Friend] = []
    
    var registrationDate: String {
        if let date = self.registered {
            return date.formatted(date: .abbreviated, time: .omitted)
        } else {
            return "Unknown"
        }
    }
    
    var uniqueTags: [String] {
        var tags = Set<String>()
        for tag in self.tags {
            tags.insert(tag)
        }
        
        return Array(tags.sorted())
    }
    
    func sortedFriends() -> [Friend] {
        self.friends.sorted(by: { $0.name < $1.name })
    }
}
