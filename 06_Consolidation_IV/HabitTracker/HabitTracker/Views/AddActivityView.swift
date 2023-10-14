//
//  AddActivityView.swift
//  HabitTracker
//
//  Created by Adnan Boxwala on 12.10.23.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var activities: Activities
    @State private var title = ""
    @State private var description = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(5, reservesSpace: true)
                        .textInputAutocapitalization(.sentences)
                }
            }
            .navigationTitle("Add new activity")
            .toolbar {
                Button {
                    if title.trimmingCharacters(in: .whitespaces).count == 0 {
                        showingAlert = true
                        return
                    }
                    let item = Activity(title: title, description: description, count: 0)
                    activities.items.append(item)
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
            .alert("Empty field", isPresented: $showingAlert) {
                Button("Ok", role: .cancel) { }
            } message: {
                Text("Please provide a title.")
            }
        }
    }
}

#Preview {
    AddActivityView(activities: Activities())
}
