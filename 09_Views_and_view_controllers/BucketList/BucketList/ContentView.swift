//
//  ContentView.swift
//  BucketList
//
//  Created by Adnan Boxwala on 10.12.23.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    )
    
    var body: some View {
        NavigationStack {
            Map(position: $position) {
                Marker("Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141))
                
                Annotation("Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076), anchor: .center) {
                    NavigationLink {
                        Text("Tower of London")
                    } label: {
                        Circle()
                            .stroke(.red, lineWidth: 3)
                            .frame(width: 44, height: 44)
                    }
                }
            }
            .navigationTitle("London Explorer")
        }
    }
}


#Preview {
    ContentView()
}
