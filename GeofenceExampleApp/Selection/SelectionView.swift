//
//  SelectionView.swift
//  GeofenceExampleApp
//
//  Created by Eren Erinanç on 5.05.2025.
//

import Foundation
import SwiftUI
import GeofenceInterface

class SelectionViewModel: ObservableObject {
    let availableLocations: [GeoLocation] = [
        GeoLocation(name: "Kadıköy", latitude: 40.9890, longitude: 29.0280),
        GeoLocation(name: "Beşiktaş", latitude: 41.0438, longitude: 29.0094),
        GeoLocation(name: "Bornova", latitude: 38.4692, longitude: 27.2220),
        GeoLocation(name: "Alsancak", latitude: 38.4332, longitude: 27.1302),
        GeoLocation(name: "Bostanlı", latitude: 38.9422, longitude: 30.6364)
    ]
    @Published var selectedLocations: [GeoLocation] = []
}

struct SelectionView: View {
    @ObservedObject var viewModel: SelectionViewModel
    let selectionHandler: ([GeoLocation]) -> Void
    
    init(
        viewModel: SelectionViewModel,
        selectionHandler: @escaping ([GeoLocation]) -> Void
    ) {
        self.viewModel = viewModel
        self.selectionHandler = selectionHandler
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                List(viewModel.availableLocations, id: \.name) { location in
                    Button(action: {
                        if viewModel.selectedLocations.contains(where: { $0.name == location.name }) {
                            viewModel.selectedLocations.removeAll(where: { $0.name == location.name })
                        } else {
                            viewModel.selectedLocations.append(location)
                        }
                    }) {
                        HStack {
                            Text(location.name)
                            Spacer()
                            if viewModel.selectedLocations.contains(where: { $0.name == location.name }) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }

                Button("Start Geofence") {
                    selectionHandler(viewModel.selectedLocations)
                }
                .disabled(viewModel.selectedLocations.isEmpty)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .navigationTitle("Select Locations")
        }
    }
}
