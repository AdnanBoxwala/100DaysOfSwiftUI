//
//  User.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 29.10.23.
//

import Foundation

class Database: ObservableObject {
    @Published var users = [User]()
    
    func find(with id: String) -> User? {
        self.users.first { $0.id == id }
    }
}
