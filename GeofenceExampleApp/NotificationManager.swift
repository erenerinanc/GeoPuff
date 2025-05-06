//
//  NotificationManager.swift
//  GeofenceExampleApp
//
//  Created by Eren Erinanç on 6.05.2025.
//

import Foundation
import NotificationCenter

extension Notification.Name {
    static let didReceiveLocationNotification = Notification.Name("didReceiveLocationNotification")
}


final class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()
    private override init() {}
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .badge, .sound])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        NotificationCenter.default.post(
            name: .didReceiveLocationNotification,
            object: nil,
            userInfo: userInfo
        )

        completionHandler()
    }

}
