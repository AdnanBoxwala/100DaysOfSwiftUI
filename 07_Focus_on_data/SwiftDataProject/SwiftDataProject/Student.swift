//
//  Student.swift
//  SwiftDataProject
//
//  Created by Adnan Boxwala on 28.07.24.
//

import Foundation
import SwiftData

@Model
class Student {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
