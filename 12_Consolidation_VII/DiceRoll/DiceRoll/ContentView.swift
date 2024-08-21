//
//  ContentView.swift
//  DiceRoll
//
//  Created by Adnan Boxwala on 16.08.24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    @State private var isRolling = false
    @State private var rolledNumbers = Array(repeating: 0, count: 3)
    
    let diceCountOptions = 1...3
    @State private var diceCount = 1
    @State private var diceType = DiceType.fourSide
    
    @State private var showingPreviousResults = false
    
    var totalRollCount: Int {
        return rolledNumbers[..<diceCount].reduce(0, +)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                VStack {
                    List {
                        Section {
                            Picker("Count", selection: $diceCount) {
                                ForEach(diceCountOptions, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.navigationLink)
                            
                            Picker("Type", selection: $diceType) {
                                ForEach(DiceType.allCases, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.navigationLink)
                        } header: {
                            Text("Dice Configuration")
                        }
                    }
                    .listStyle(.plain)
                    .frame(maxHeight: 150)
                    
                    LazyHGrid(rows: [GridItem(.adaptive(minimum: 120, maximum: 150))]) {
                        ForEach(0..<diceCount, id: \.self) { index in
                            DiceView(rolledNumber: rolledNumbers[index])
                                .frame(minWidth: 100, maxWidth: 110, minHeight: 100, maxHeight: 110)
                        }
                    }
                    
                    if isRolling == false {
                        Text("Total: \(totalRollCount)")
                            .font(.largeTitle)
                    }
                    
                    Button {
                        rollDice()
                    } label: {
                        Text("Roll \(Image(systemName: "die.face.3"))")
                            .font(.title)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.primary)
                            .background(isRolling ? Color.gray : Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                    }
                    .padding(.horizontal)
                }
                .disabled(isRolling == true)
                .toolbar {
                    Button("History") {
                        showingPreviousResults = true
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Roll The Dice...")
            .onReceive(timer, perform: { time in
                guard counter < 10 else {
                    reset()
                    saveRoll()
                    return
                }
                if isRolling {
                    updateFlick()
                    counter += 1
                }
            })
            .sheet(isPresented: $showingPreviousResults) {
                PreviousRollsView()
            }
        }
    }
    
    func rollDice() {
        isRolling = true
        timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    }
    
    func saveRoll() {
        let diceConfig = Dice(count: diceCount, numberOfSides: diceType)
        let rolledValue = RolledValue(dice: diceConfig, values: rolledNumbers, total: totalRollCount)
        modelContext.insert(rolledValue)
    }
    
    func reset() {
        timer.upstream.connect().cancel()
        isRolling = false
        counter = 0
    }
    
    func updateFlick() {
        for index in 0..<diceCount {
            let randomNumber = Int.random(in: 1...diceType.rawValue)
            rolledNumbers[index] = randomNumber
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: RolledValue.self, configurations: config)
        return ContentView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create container")
    }
}
