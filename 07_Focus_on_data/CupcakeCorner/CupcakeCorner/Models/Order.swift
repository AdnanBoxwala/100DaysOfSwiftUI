//
//  Order.swift
//  CupcakeCorner
//
//  Created by Adnan Boxwala on 15.10.23.
//

import SwiftUI

class Order: ObservableObject {
    struct Details: Codable {
        static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
        
        var type = 0
        var quantity = 3
        
        var specialRequestEnabled = false {
            didSet {
                if specialRequestEnabled == false {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
        var extraFrosting = false
        var addSprinkles = false
        
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
        
        var hasValidAddress: Bool {
            if name.isNotEmpty && streetAddress.isNotEmpty && streetAddress.isValidAddress && city.isNotEmpty && city.isAlpha && zip.isNotEmpty && zip.isNumeric {
                return true
            }

            return false
        }
        
        var cost: Double {
            // $2 per cake
            var cost = Double(quantity) * 2
            
            // complicated cakes cost more
            cost += Double(type) / 2
            
            // $1/cake for extra frosting
            if extraFrosting {
                cost += Double(quantity)
            }
            
            // $0.50/cake sprinkles
            if addSprinkles {
                cost += Double(quantity) / 2
            }
            
            return cost
        }
    }
    
    @Published var details = Details()
    
//    init() { }
//    
//    enum CodingKeys: CodingKey {
//        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//        
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//        
//        try container.encode(name, forKey: .name)
//        try container.encode(streetAddress, forKey: .streetAddress)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        type = try container.decode(Int.self, forKey: .type)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//        
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//        
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
//    }
}
