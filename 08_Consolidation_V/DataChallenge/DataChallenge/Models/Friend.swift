//
//  Friend.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 29.10.23.
//

import Foundation

struct Friend: Codable {
    enum CodingKeys: String, CodingKey {
        case serverId = "id"
        case name = "name"
    }
    
//    let id: String
    let serverId: String
    let name: String
}
