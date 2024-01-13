//
//  FileManager-Decodable.swift
//  BucketList
//
//  Created by Adnan Boxwala on 10.12.23.
//

import Foundation

extension FileManager {
    func encode<T:Codable>(_ content: T, to filename: String, completionHandler: @escaping (Error) -> Void) {
        let url = URL.documentsDirectory.appending(path: filename)
        
        let encoder = JSONEncoder()
        
        do {
            let encodedContent = try encoder.encode(content)
            try encodedContent.write(to: url, options: [.atomic, .completeFileProtection])
        } catch {
            completionHandler(error)
        }
    }
    
    func decode<T: Codable>(from filename: String, completionHandler: @escaping (Error) -> Void) -> T? {
        let url = URL.documentsDirectory.appending(path: filename)
        
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: url)
            let decodedContent = try decoder.decode(T.self, from: data)
            return decodedContent
        } catch {
            completionHandler(error)
            return nil
        }        
    }
}


