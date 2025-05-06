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

}

