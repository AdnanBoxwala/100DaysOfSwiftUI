import Cocoa

let names: [String] = ["Jason", "Alex", "Alicia", "Jonas", "Elena", "Susanne", "Isabel", "Fabian", "Jason"]
print("Number of items in \"names\" array: \(names.count)")

let uniqueNames: Set<String> = Set(names)
print("Number of unique items in \"names\" array: \(uniqueNames.count)")
