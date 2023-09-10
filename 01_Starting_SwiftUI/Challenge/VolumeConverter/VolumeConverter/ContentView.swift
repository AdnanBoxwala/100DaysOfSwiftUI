//
//  ContentView.swift
//  VolumeConverter
//
//  Created by Adnan Boxwala on 10.09.23.
//

import SwiftUI

struct ContentView: View {
    @State private var inputMetric: String = "ml"
    @State private var outputMetric: String = "L"
    @State private var inputValue: Double = 1000.0
    @FocusState private var valueIsFocused: Bool
    
    private let metrics = ["ml", "L", "cups", "pints", "gallons"]
    
    private var result: Double {
        let baseUnitValue: Double
        switch (inputMetric) {
        case "ml":
            baseUnitValue = inputValue
        case "L":
            baseUnitValue = inputValue * 1000.0
        case "cups":
            baseUnitValue = inputValue * 236.588
        case "pints":
            baseUnitValue = inputValue * 473.176
        case "gallons":
            baseUnitValue = inputValue * 3785.41
        default:
            baseUnitValue = inputValue
        }
        
        let targetUnitValue: Double
        switch (outputMetric) {
        case "ml":
            targetUnitValue = baseUnitValue
        case "L":
            targetUnitValue = baseUnitValue / 1000.0
        case "cups":
            targetUnitValue = baseUnitValue / 236.588
        case "pints":
            targetUnitValue = baseUnitValue / 473.176
        case "gallons":
            targetUnitValue = baseUnitValue / 3785.41
        default:
            targetUnitValue = baseUnitValue
        }
        
        return targetUnitValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    metricPicker(for: "Input metric", using: metrics, binding: $inputMetric)
                    TextField("Input value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocused)
                } header: {
                    Text("Input")
                }
                
                Section {
                    metricPicker(for: "Output metric", using: metrics, binding: $outputMetric)
                } header: {
                    Text("Convert to unit")
                }
                
                Section {
                    Text(result, format: .number)
                } header: {
                    Text("Converted value")
                }
            }
            .navigationTitle("Volume Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        valueIsFocused = false
                    }
                }
            }
        }
    }
    
    /// Create a segmented style picker for measurement units
    /// - Parameters:
    ///   - name: name of the picker
    ///   - metrics: string array containing names of measurement units
    ///   - value: binding to store the state
    /// - Returns: Picker
    private func metricPicker(for name: String, using metrics: [String], binding value : Binding<String>) -> some View {
        Picker(name, selection: value) {
            ForEach(metrics, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(.segmented)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
