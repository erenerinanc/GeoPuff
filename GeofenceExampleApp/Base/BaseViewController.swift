//
//  BaseViewController.swift
//  GeofenceExampleApp
//
//  Created by Eren Erinanç on 5.05.2025.
//

import Foundation
import SwiftUI

class BaseViewController: UIViewController {
    
    @discardableResult
    func addSwiftUIView<Content: View>(_ swiftUIView: Content) -> UIHostingController<Content> {
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        hostingController.didMove(toParent: self)
        return hostingController
    }
}
