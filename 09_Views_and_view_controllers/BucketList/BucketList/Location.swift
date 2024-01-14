//
//  Location.swift
//  BucketList
//
//  Created by Adnan Boxwala on 14.01.24.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitutde: Double
}
