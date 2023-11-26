//
//  CachedFriend+CoreDataProperties.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 02.11.23.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var serverId: String?
    @NSManaged public var name: String?
    @NSManaged public var origin: CachedUser?
    
    public var wrappedName: String {
        name ?? ""
    }
    
    public var wrappedServerId: String {
        serverId ?? UUID().uuidString
    }
}

extension CachedFriend : Identifiable {

}
