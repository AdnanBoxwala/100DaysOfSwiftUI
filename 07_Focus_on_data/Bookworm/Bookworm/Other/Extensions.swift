//
//  Extensions.swift
//  Bookworm
//
//  Created by Adnan Boxwala on 24.10.23.
//

import Foundation

extension String {
    var isNotEmpty: Bool {
        return !self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
