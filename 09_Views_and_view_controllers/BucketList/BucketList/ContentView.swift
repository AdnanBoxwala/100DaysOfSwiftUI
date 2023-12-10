//
//  ContentView.swift
//  BucketList
//
//  Created by Adnan Boxwala on 10.12.23.
//

import SwiftUI

enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("success...")
    }
}

struct FailedView: View {
    var body: some View {
        Text("failed...")
    }
}

struct ContentView: View {
    var loadingState = LoadingState.failed
    
    var body: some View {
        switch loadingState {
        case .loading:
            LoadingView()
        case .success:
            SuccessView()
        case .failed:
            FailedView()
        }
    }
}

#Preview {
    ContentView()
}
