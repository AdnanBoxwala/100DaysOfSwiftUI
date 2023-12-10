//
//  ContentView.swift
//  BucketList
//
//  Created by Adnan Boxwala on 10.12.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .onTapGesture {
                    let str = "Test Message"
                    do {
                        try FileManager.default.encode(str, to: "message.txt")
                        
                        let input: String = try FileManager.default.decode(from: "message.txt")
                        print(input)
                    } catch FileManager.FileManagerError.writeError {
                        print("Failed to write content to documents directory.")
                    } catch FileManager.FileManagerError.loadError {
                        print("Failed to load content from documents directory.")
                    } catch {
                        print("Unknown error.")
                    }
                }
        }
        .padding()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

#Preview {
    ContentView()
}
