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
    let availableLocations = GeoSelectionModel.ViewModel.availableLocations
    @Published var selectedLocations: [GeoLocation] = []
    @Published var notifiedLocation: GeoLocation?
    @Published var isEntered: Bool = false
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

                GeoButton(
                    title: "start_geofence_button".localized(),
                    action: {
                        selectionHandler(viewModel.selectedLocations)
                    },
                    isEnabled: !viewModel.selectedLocations.isEmpty
                )
        
                if let location = viewModel.notifiedLocation {
                    GeoInfoView(
                        iconImage: viewModel.isEntered ? "location.fill" : "arrow.uturn.left.circle.fill",
                        foregroundColor: viewModel.isEntered ? .green : .orange,
                        title: viewModel.isEntered ? "entered_region_title".localized(with: location.name) : "exited_region_title".localized(with: location.name),
                        subtitle: viewModel.isEntered
                        ? "entered_region_subtitle".localized()
                        : "exited_region_subtitle".localized(),
                        actionHandler: {
                            viewModel.notifiedLocation = nil
                        },
                        backgroundColor: viewModel.isEntered ? Color.green : Color.orange,
                        notifiedLocation: viewModel.notifiedLocation?.name ?? "")
                }

            }
            .navigationTitle("Select Locations")
        }
    }
}
