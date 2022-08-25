//
//  SampleNotificationDelegate.swift
//  SocialMedia
//
//  Created by Abdul on 02/06/22.
//

import Foundation
import UserNotifications
import UserNotificationsUI
import FirebaseMessaging
import Messages

//class SampleNotificationDelegate: NSObject , UNUserNotificationCenterDelegate,MessagingDelegate {
//
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.alert,.sound])
//        let userInfo = notification.request.content.userInfo
//        Messaging.messaging().appDidReceiveMessage(userInfo)
//    }
//
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        switch response.actionIdentifier {
//        case UNNotificationDismissActionIdentifier:
//            print("Dismiss Action")
//        case UNNotificationDefaultActionIdentifier:
//            print("Open Action")
//
//            let userInfo = response.notification.request.content.userInfo
//
//            Messaging.messaging().appDidReceiveMessage(userInfo)
//
//            completionHandler()
//
//
//
//print("userInfo",userInfo)
//
//        case "Snooze":
//            print("Snooze")
//        case "Delete":
//            print("Delete")
//        default:
//            print("default")
//        }
//        completionHandler()
//    }
//    func application(_ application: UIApplication,
//    didReceiveRemoteNotification userInfo: [AnyHashable : Any],
//       fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//      Messaging.messaging().appDidReceiveMessage(userInfo)
//      completionHandler(.noData)
//    }
//
//
//
//
//}

import Foundation
import UserNotifications
import UserNotificationsUI

class SampleNotificationDelegate: NSObject , UNUserNotificationCenterDelegate {
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Open Action")
        case "Snooze":
            print("Snooze")
        case "Delete":
            print("Delete")
        default:
            print("default")
        }
        completionHandler()
    }
}
