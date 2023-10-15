//
//  Extensions.swift
//  CupcakeCorner
//
//  Created by Adnan Boxwala on 15.10.23.
//

import Foundation

extension String {
    var isNotNumeric: Bool {
        guard let _ = Int(self) else {
            return true
        }
        return false
    }
}
