//
//  FileManager-Decodable.swift
//  BucketList
//
//  Created by Adnan Boxwala on 10.12.23.
//

import Foundation

extension FileManager {
    
    enum FileManagerError: Error {
        case writeError
        case loadError
    }
    
    func encode<T:Codable>(_ content: T, to filename: String) throws {
        let url = Self.documentsDirectory.appendingPathComponent(filename)
        
        let encoder = JSONEncoder()
        
        do {
            let encodedContent = try encoder.encode(content)
            try encodedContent.write(to: url)
        } catch {
            throw FileManagerError.writeError
        }
    }
    
    func decode<T: Codable>(from filename: String) throws -> T {
        let url = Self.documentsDirectory.appendingPathComponent(filename)
        
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: url)
            let decodedContent = try decoder.decode(T.self, from: data)
            return decodedContent
        } catch {
            throw FileManagerError.loadError
        }
    }
    
    static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}


