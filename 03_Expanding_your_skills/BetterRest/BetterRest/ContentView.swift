//
//  ContentView.swift
//  BetterRest
//
//  Created by Adnan Boxwala on 20.09.23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    private var bedTime: String {
        calculateBedtime()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("When do you want to wake up?")
                        .font(.headline)
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                        .font(.headline)
                }
                
                Section {
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(1..<21, id: \.self) { amount in
                            Text(amount == 1 ? "1 cup" : "\(amount) cups")
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("Daily coffee intake")
                        .font(.headline)
                }
                
                Section {
                    Text("\(bedTime)")
                        .font(.largeTitle)
                } header: {
                    Text("Your ideal bedtime is...")
                        .font(.headline)
                }
            }
            .navigationTitle("BetterRest")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("Ok") { }
            } message: {
                Text("\(alertMessage)")
            }
        }
    }
    
    func calculateBedtime() -> String {
        var bedTime: String = ""
        
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            bedTime = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            showingAlert = true
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        return bedTime
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
