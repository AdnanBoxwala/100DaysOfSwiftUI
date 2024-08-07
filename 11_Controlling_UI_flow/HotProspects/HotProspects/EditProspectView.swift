//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Adnan Boxwala on 05.08.24.
//

import SwiftUI

// Challenge 2:
struct EditProspectView: View {
    @Bindable var prospect: Prospect
    
    var body: some View {
        Form {
            Section {
                TextField(prospect.name, text: $prospect.name)
            } header: {
                Text("Name")
            }
            
            Section {
                TextField(prospect.emailAddress, text: $prospect.emailAddress)
            } header: {
                Text("Email Address")
            }
        }
        .navigationTitle("Edit details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    EditProspectView(prospect: Prospect(name: "Your Name", emailAddress: "yourname@yourwebsite.com", isContacted: false, dateAdded: .now))
}
