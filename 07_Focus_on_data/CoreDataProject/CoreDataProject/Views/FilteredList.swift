//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Adnan Boxwala on 28.10.23.
//

import SwiftUI

struct FilteredList: View {
    @FetchRequest var fetchRequest: FetchedResults<Singer>
    
    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
    
    init(filter: String) {
        _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH[c] %@", filter))
    }
}

//#Preview {
//    FilteredList()
//}
