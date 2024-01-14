//
//  ContentView.swift
//  BucketList
//
//  Created by Adnan Boxwala on 10.12.23.
//

import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    let locations = [
        Location(name: "buckingham palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "tower of london", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    var body: some View {
        VStack {
            Map {
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Text(location.name)
                            .font(.headline)
                            .padding()
                            .background(.blue.gradient)
                            .foregroundStyle(.white)
                            .clipShape(.capsule)
                    }
                    .annotationTitles(.hidden)
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
