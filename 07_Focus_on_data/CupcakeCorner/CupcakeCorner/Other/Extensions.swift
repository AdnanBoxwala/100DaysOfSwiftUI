//
//  Extensions.swift
//  CupcakeCorner
//
//  Created by Adnan Boxwala on 15.10.23.
//

import Foundation

extension String {
    var isNotEmpty: Bool {
        return !self.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var isValidAddress: Bool {
        // regex to check if string contains anything other than alphanumeric, period or space
        return !self.contains(/[^a-zA-z0-9. ]/)
    }
    
    var isAlpha: Bool {
        // regex to check if string contains any digit
        return !self.contains(/\d/)
    }
    
    var isNumeric: Bool {
        // regex to check if string contains any non-digit
        return !self.contains(/\D/)
    }
}
