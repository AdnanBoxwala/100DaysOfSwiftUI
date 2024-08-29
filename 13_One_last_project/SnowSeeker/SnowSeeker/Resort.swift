//
//  Resort.swift
//  SnowSeeker
//
//  Created by Adnan Boxwala on 27.08.24.
//

import Foundation

struct Resort: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    var runs: Int
    var facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
//    static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]
    static let example = allResorts[0]
}