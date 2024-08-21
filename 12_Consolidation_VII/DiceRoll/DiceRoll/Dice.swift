//
//  Dice.swift
//  DiceRoll
//
//  Created by Adnan Boxwala on 16.08.24.
//

import Foundation
import SwiftData

enum DiceType: Int, CaseIterable, Codable {
    case fourSide = 4
    case sixSide = 6
    case eightSide = 8
    case tenSide = 10
    case twelveSide = 12
    case twentySide = 20
    case hundredSide = 100
}

struct Dice: Codable {
    var count: Int
    var numberOfSides: DiceType
}

@Model
class RolledValue {
    var dice: Dice
    var values: [Int]
    var total: Int
    
    init(dice: Dice, values: [Int], total: Int) {
        self.dice = dice
        self.values = values
        self.total = total
    }
}
