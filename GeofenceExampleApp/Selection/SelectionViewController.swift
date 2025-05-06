//
//  ViewController.swift
//  GeofenceExampleApp
//
//  Created by Eren Erinanç on 5.05.2025.
//

import UIKit
import SwiftUI
import GeofenceInterface

class SelectionViewController: BaseViewController {
    let viewModel = SelectionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwiftUIView()
        listenNotifications()
    }
    
    private func addSwiftUIView() {
        let suiView = SelectionView(viewModel: viewModel) { locations in
            Task {
                let authorized = try? await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
                if authorized == true {
                    GeoManager.shared.startGeofenceMonitoring(locations: locations)
                }
            }
        }

        addSwiftUIView(suiView)
    }
    
    private func listenNotifications() {
        NotificationCenter.default.addObserver(
            forName: .didReceiveLocationNotification,
            object: nil,
            queue: .main
        ) { notification in
            if let locationId = notification.userInfo?["regionId"] as? String {
                GeoManager.shared.stopMonitoring()
                let geoLocation = GeoSelectionModel.ViewModel.getSelectedLocation(with: locationId)
                self.viewModel.notifiedLocation = geoLocation
            }
            
            if let isEntered = notification.userInfo?["isEntered"] as? Bool {
                self.viewModel.isEntered = isEntered
            }
        }

    }

}

