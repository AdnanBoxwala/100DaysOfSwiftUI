//
//  ContentView.swift
//  BucketList
//
//  Created by Adnan Boxwala on 10.12.23.
//

import LocalAuthentication
import SwiftUI

struct ContentView: View {
    @State private var isunlocked = false
    
    var body: some View {
        VStack {
            if isunlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    isunlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
            print(error?.localizedDescription ?? "no biometrics")
        }
    }
}


#Preview {
    ContentView()
}
