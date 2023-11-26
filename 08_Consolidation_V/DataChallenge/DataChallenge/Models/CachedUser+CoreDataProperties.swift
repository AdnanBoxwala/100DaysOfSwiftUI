//
//  CachedUser+CoreDataProperties.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 02.11.23.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var date: Date?
    @NSManaged public var email: String?
    @NSManaged public var serverId: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var tags: String?
    @NSManaged public var cachedFriend: NSSet?
    
    public var wrappedAbout: String {
        about ?? "Missing information"
    }
    public var wrappedAddress: String {
        address ?? "-"
    }
    public var wrappedCompany: String {
        company ?? "-"
    }
    public var wrappedDate: String {
        date?.formatted(date: .abbreviated, time: .omitted) ?? "-"
    }
    public var wrappedEmail: String {
        email ?? ""
    }
    public var wrappedServerId: String {
        serverId ?? UUID().uuidString
    }
    public var wrappedname: String {
        name ?? "-"
    }
    public var wrappedTags: [String] {
        let tagsArray = tags?.components(separatedBy: ",") ?? [String]()
        var uniqueTags = Set<String>()
        for tag in tagsArray {
            uniqueTags.insert(tag)
        }
        return Array(uniqueTags.sorted())
    }
    
    public var cachedFriendArray: [CachedFriend] {
        let set = cachedFriend as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for cachedFriend
extension CachedUser {

    @objc(addCachedFriendObject:)
    @NSManaged public func addToCachedFriend(_ value: CachedFriend)

    @objc(removeCachedFriendObject:)
    @NSManaged public func removeFromCachedFriend(_ value: CachedFriend)

    @objc(addCachedFriend:)
    @NSManaged public func addToCachedFriend(_ values: NSSet)

    @objc(removeCachedFriend:)
    @NSManaged public func removeFromCachedFriend(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
