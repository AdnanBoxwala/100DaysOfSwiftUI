//
//  PreviousRollsView.swift
//  DiceRoll
//
//  Created by Adnan Boxwala on 20.08.24.
//

import SwiftData
import SwiftUI

struct PreviousRollsView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query var rolledValues: [RolledValue]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(rolledValues, id: \.self) { result in
                    HStack {
                        VStack {
                            Text("\(result.dice.count) x \(Image(systemName: "die.face.3"))")
                            Text("D\(result.dice.numberOfSides.rawValue)")
                        }
                        .bold()
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("\(result.total)")
                                .font(.title)
                            Text("\(result.values[..<result.dice.count])")
                                .font(.caption)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Clear") {
                        for value in rolledValues {
                            modelContext.delete(value)
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Previous Rolls")
        }
    }
}

#Preview {
    PreviousRollsView()
}
