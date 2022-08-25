//
//  AppDelegate.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 09/03/22.
//

import UIKit
import CoreData
import UserNotifications
import FirebaseCore
import FirebaseMessaging
import Messages

//Notification Succuess 

 @main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var imageview : UIImageView?
    var gcmMessageIDKey  =  "gcm.messageID"
    
    static var fcmToken: String?
    let notificationDelegate = SampleNotificationDelegate()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
//        let notificationCenter = UNUserNotificationCenter.current()
//               notificationCenter.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
//                   // Enable or disable features based on authorization.
//               }
//               notificationCenter.delegate = self
//               application.registerForRemoteNotifications()
           //    application.applicationIconBadgeNumber = 0

        configureNotification()
               FirebaseApp.configure()
               Messaging.messaging().delegate = self
        
//        configureNotification()
//        FirebaseApp.configure()
//        Messaging.messaging().delegate = self
        
        
        return true
    }
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(.newData)
    }
    
    
    func configureNotification() {
        
        
//        UNUserNotificationCenter.current().delegate = self
//        
//        let starAction = UNNotificationAction(identifier: "star", title: "Star My ", options: [])
//        let dissmissAction = UNNotificationAction(identifier: "dissmiss", title: "dissmiss My ", options: [])
//        
//        let catogry = UNNotificationCategory(identifier: "akshay", actions: [starAction,dissmissAction], intentIdentifiers: [], options: [])
//        
//        UNUserNotificationCenter.current().setNotificationCategories([catogry])

//        
//        let userNotificationAction:UNNotificationAction = UNNotificationAction.init(identifier: "ID1", title: "வணக்கம்", options: .destructive)
//           let userNotificationAction2:UNNotificationAction = UNNotificationAction.init(identifier: "ID2", title: "Success", options: .destructive)
//
//           let notifCategory:UNNotificationCategory = UNNotificationCategory.init(identifier: "akshay", actions: [userNotificationAction,userNotificationAction2], intentIdentifiers: ["ID1","ID2"] , options:.customDismissAction)
//
//           UNUserNotificationCenter.current().delegate = self
//           UNUserNotificationCenter.current().setNotificationCategories([notifCategory])
//           UIApplication.shared.registerForRemoteNotifications()
        

        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            center.delegate = notificationDelegate
            let openAction = UNNotificationAction(identifier: "Okay", title: NSLocalizedString("Abrir", comment: ""), options: UNNotificationActionOptions.foreground)
            let deafultCategory = UNNotificationCategory(identifier: "akshay", actions: [openAction], intentIdentifiers: [], options: [])
            center.setNotificationCategories(Set([deafultCategory]))
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SocialMedia")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
        imageview = UIImageView.init(image: UIImage.init(named: "bg_splash"))
        //            self.window?.addSubview(imageview!)
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if (imageview != nil){
            
            imageview?.removeFromSuperview()
            imageview = nil
        }
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
}



@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
      let userInfo = notification.request.content.userInfo
      // Print message ID.
      print("aps: \(userInfo)")
//      // Showing notification in a popup
//              if let apsDict = userInfo["aps"] as? NSDictionary{
//                  if let alertDict = apsDict["alert"] as? NSDictionary{
//                      if ((alertDict["body"] as? String) != nil) && ((alertDict["title"] as? String) != nil){
//                          if (UIApplication.shared.applicationState == UIApplication.State.active) {
//                              let message = alertDict["body"] as! String
//                              let title = alertDict["title"] as! String
////                              Utilities.sharedInstance.alertWithOkButtonAction(vc: (UIApplication.shared.delegate?.window??.rootViewController)!, alertTitle: "Notification", messege: message, clickAction: {
////
////                              })
//                              showAlert(alertTitle: title, aleertMessage: message)
//                          }
//                      }
//                  }
//              }
//      if let apsDict1 = userInfo["urlImageString"] as? String{
//  print("apsDictapsDict",apsDict1)
//      }
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aps"), object: .none)
      

      completionHandler([.sound,.alert])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
   // let userInfo = response.notification.request.content.userInfo

    // ...

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print full message.
   // print(userInfo)
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "aps"), object: .none)

    completionHandler()
  }
    
}

extension AppDelegate : MessagingDelegate {
    
    // The callback to handle data message received via FCM for devices running iOS 10 or above.
//    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
//        print(remoteMessage.appData)
//    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("fcmTokenfcmToken:",fcmToken)
        
        let defaults = UserDefaults.standard
        defaults.set(fcmToken , forKey: "DeviceToken")
        
    }
    func showAlert(alertTitle : String , aleertMessage : String) {
        let alertController = UIAlertController(title: alertTitle, message: aleertMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
            UIAlertAction in
            // action
        }
        alertController.addAction(okAction)
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
