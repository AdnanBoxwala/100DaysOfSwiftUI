//
//  ContentView.swift
//  BucketList
//
//  Created by Adnan Boxwala on 10.12.23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Button("Read and Write") {
            let content = "Test Message"
            let filename = "message.txt"
            
            FileManager.default.encode(content, to: filename) { error in
                print(error.localizedDescription)
            }
            
            if let readContent: String = FileManager.default.decode(from: filename, completionHandler: { error in
                print(error.localizedDescription)
            }) {
                print(readContent)
            }
        }
    }
}


#Preview {
    ContentView()
}
