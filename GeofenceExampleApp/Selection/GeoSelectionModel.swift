//
//  GeoSelectionModel.swift
//  GeofenceExampleApp
//
//  Created by Eren Erinanç on 6.05.2025.
//

import Foundation
import GeofenceInterface

enum GeoSelectionModel {
    public struct ViewModel {
        static let availableLocations: [GeoLocation] = [
            GeoLocation(id: "kdky", name: "Kadıköy", latitude: 40.9890, longitude: 29.0280),
            GeoLocation(id: "bskts", name: "Beşiktaş", latitude: 41.0438, longitude: 29.0094),
            GeoLocation(id: "brnv", name: "Bornova", latitude: 38.4692, longitude: 27.2220),
            GeoLocation(id: "alsnck", name: "Alsancak", latitude: 38.4332, longitude: 27.1302),
            GeoLocation(id: "bstnl", name: "Bostanlı", latitude: 38.9422, longitude: 30.6364)
        ]
        
        static func getSelectedLocation(with id: String) -> GeoLocation? {
            return Self.availableLocations.first { $0.id == id }
        }
    }
}
