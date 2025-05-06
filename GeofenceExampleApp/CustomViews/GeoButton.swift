//
//  GeoButton.swift
//  GeofenceExampleApp
//
//  Created by Eren Erinanç on 6.05.2025.
//

import Foundation
import SwiftUI

public struct GeoButton: View {
    public let title: String
    public let action: () -> Void
    public let isEnabled: Bool
    
    public var body: some View {
        Button(title) {
            action()
        }
        .disabled(!isEnabled)
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}
