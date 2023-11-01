//
//  BasicUserView.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 30.10.23.
//

import SwiftUI

struct BasicUserView: View {
    let name: String
    let status: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.headline)
                HStack {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(status ? .green : .gray)
                    Text("\(status ? "Active" : "Inactive")")
                        .font(.caption)
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(10)
        .background(.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    BasicUserView(name: "Adnan", status: true)
}
