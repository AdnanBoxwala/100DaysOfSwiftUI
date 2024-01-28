//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Adnan Boxwala on 18.01.24.
//

import CoreLocation
import Foundation
import LocalAuthentication
import MapKit
import _MapKit_SwiftUI

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        var isUnlocked = false
        var isHybrid = true
        var showingAlert = false
        let alertTitle = "Authentication failed!"
        var alertMessage = ""
        
        var mapStyle: MapStyle {
            isHybrid ? MapStyle.hybrid(elevation: .realistic) : MapStyle.standard
        }
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace else {return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                        // SwiftUI shows alert automatically
                    }
                }
            } else {
                // no biometrics
                
                if context.biometryType.rawValue == LABiometryType.none.rawValue {
                    // Functionality not available out of the box.
                    // Add new View for this feature.
                    self.alertMessage = "Device does not support biometrics. Authenticate using PIN."
                } else {
                    self.alertMessage = "Allow permission to biometrics in Settings."
                }
                self.showingAlert = true
            }
        }
    }
}
