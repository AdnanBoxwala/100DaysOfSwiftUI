//
//  ComparisonOperator.swift
//  CoreDataProject
//
//  Created by Adnan Boxwala on 29.10.23.
//

import Foundation

enum ComparisonOperator: String {
    case lessThan = "LESSTHAN"
    case lessThanOrEqualTo = "LESSTHANOREQUALTO"
    case greaterThan = "GREATERTHAN"
    case greaterThanOrEqualTo = "GREATERTHANOREQUALTO"
    case equalTo = "EQUALTO"
    case notEqualTo = "NOTEQUALTO"
    case matches = "MATCHES"
    case like = "LIKE"
    case beginsWith = "BEGINSWITH"
    case endsWith = "ENDSWITH"
    case `in` = "IN"
    case contains = "CONTAINS"
    case between = "BETWEEN"
}
