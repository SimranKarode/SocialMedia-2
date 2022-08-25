//
//  NotificationService.swift
//  Service
//0
//  Created by Abdul on 02/06/22.
//

//import UserNotifications
//
//class NotificationService: UNNotificationServiceExtension {
    
//    var contentHandler: ((UNNotificationContent) -> Void)?
//    var bestAttemptContent: UNMutableNotificationContent?
//
//    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
//        self.contentHandler = contentHandler
//        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
//
//
//        if let bestAttemptContent = bestAttemptContent {
//            // Modify the notification content here...
//            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
//
//            var urlString:String? = nil
//            if let urlImageString = request.content.userInfo["urlImageString"] as? String {
//                urlString = urlImageString
//            }
//
//            if urlString != nil, let fileUrl = URL(string: urlString!) {
//                print("fileUrl: \(fileUrl)")
//
//                guard let imageData = NSData(contentsOf: fileUrl) else {
//                    contentHandler(bestAttemptContent)
//                    return
//                }
//                guard let attachment = UNNotificationAttachment.saveImageToDisk(fileIdentifier: "image.jpg", data: imageData, options: nil) else {
//                    print("error in UNNotificationAttachment.saveImageToDisk()")
//                    contentHandler(bestAttemptContent)
//                    return
//                }
//
//                bestAttemptContent.attachments = [ attachment ]
//            }
//
//            contentHandler(bestAttemptContent)
//        }
//    }
//    //
//    override func serviceExtensionTimeWillExpire() {
//        // Called just before the extension will be terminated by the system.
//        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
//        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
//            contentHandler(bestAttemptContent)
//        }
//    }
//
//}
//
//
//
//   @available(iOSApplicationExtension 10.0, *)
//   extension UNNotificationAttachment {
//
//       static func saveImageToDisk(fileIdentifier: String, data: NSData, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
//           let fileManager = FileManager.default
//           let folderName = ProcessInfo.processInfo.globallyUniqueString
//           let folderURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(folderName, isDirectory: true)
//
//           do {
//               try fileManager.createDirectory(at: folderURL!, withIntermediateDirectories: true, attributes: nil)
//               let fileURL = folderURL?.appendingPathComponent(fileIdentifier)
//               try data.write(to: fileURL!, options: [])
//               let attachment = try UNNotificationAttachment(identifier: fileIdentifier, url: fileURL!, options: options)
//               return attachment
//           } catch let error {
//               print("error \(error)")
//           }
//
//           return nil
//       }
//   }
//
//
//        extension UNNotificationAttachment {
//            static func create(imageFileIdentifier: String, data: NSData, options: [NSObject : AnyObject]?, tmpSubFolderName : String) -> UNNotificationAttachment? {
//
//                let fileManager = FileManager.default
//                let tmpSubFolderName = ProcessInfo.processInfo.globallyUniqueString
//                let fileURLPath      = NSURL(fileURLWithPath: NSTemporaryDirectory())
//                let tmpSubFolderURL  = fileURLPath.appendingPathComponent(tmpSubFolderName, isDirectory: true)
//
//                do {
//                    try fileManager.createDirectory(at: tmpSubFolderURL!, withIntermediateDirectories: true, attributes: nil)
//                    let fileURL = tmpSubFolderURL?.appendingPathComponent(imageFileIdentifier)
//                    try data.write(to: fileURL!, options: [])
//                    let imageAttachment = try UNNotificationAttachment.init(identifier: imageFileIdentifier, url: fileURL!, options: options)
//                    return imageAttachment
//                } catch let error {
//                    print("error \(error)")
//                }
//
//                return nil
//            }
//        }


//import UserNotifications
//
//class NotificationService: UNNotificationServiceExtension {
//
//    var contentHandler: ((UNNotificationContent) -> Void)?
//    var bestAttemptContent: UNMutableNotificationContent?
//
//
//    funsst(request: UNNotificationRequest, withContentHandler contentHandler: (UNNotificationContent) -> Void) {
//
//
//
//}
//    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
//        self.contentHandler = contentHandler
//        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
//
//        if let bestAttemptContent = bestAttemptContent {
//            // Modify the notification content here...
//            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
//
//            var urlString:String? = nil
//            if let urlImageString = request.content.userInfo["urlImageString"] as? String {
//                urlString = urlImageString
//            }
//
//            if urlString != nil, let fileUrl = URL(string: urlString!) {
//                print("fileUrl: \(fileUrl)")
//
//                guard let imageData = NSData(contentsOf: fileUrl) else {
//                    contentHandler(bestAttemptContent)
//                    return
//                }
//                guard let attachment = UNNotificationAttachment.saveImageToDisk(fileIdentifier: "image.jpg", data: imageData, options: nil) else {
//                    print("error in UNNotificationAttachment.saveImageToDisk()")
//                    contentHandler(bestAttemptContent)
//                    return
//                }
//
//                bestAttemptContent.attachments = [ attachment ]
//            }
//
//            contentHandler(bestAttemptContent)
//        }
//    }
//
//    override func serviceExtensionTimeWillExpire() {
//        // Called just before the extension will be terminated by the system.
//        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
//        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
//            contentHandler(bestAttemptContent)
//        }
//    }
//
//}
//
//@available(iOSApplicationExtension 10.0, *)
//extension UNNotificationAttachment {
//
//    static func saveImageToDisk(fileIdentifier: String, data: NSData, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
//        let fileManager = FileManager.default
//        let folderName = ProcessInfo.processInfo.globallyUniqueString
//        let folderURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(folderName, isDirectory: true)
//
//        do {
//            try fileManager.createDirectory(at: folderURL!, withIntermediateDirectories: true, attributes: nil)
//            let fileURL = folderURL?.appendingPathComponent(fileIdentifier)
//            try data.write(to: fileURL!, options: [])
//            let attachment = try UNNotificationAttachment(identifier: fileIdentifier, url: fileURL!, options: options)
//            return attachment
//        } catch let error {
//            print("error \(error)")
//        }
//
//        return nil
//    }
//}


import Foundation
import UserNotifications
import MobileCoreServices
//import SwiftyJSON

class NotificationService: UNNotificationServiceExtension {

//    var contentHandler: ((UNNotificationContent) -> Void)?
//    var bestAttemptContent: UNMutableNotificationContent?
//
//    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
//        self.contentHandler = contentHandler
//        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
//
//        if let bestAttemptContent = bestAttemptContent {
//            let apsData = request.content.userInfo["aps"] as! [String : Any]
//            let alertData = apsData["alert"] as! [String : Any]
//            let imageData = request.content.userInfo["urlImageString"] as! [String : Any]
//            bestAttemptContent.title = (alertData["title"] as? String) ?? ""
//            bestAttemptContent.body = (alertData["body"] as? String) ?? ""
//
//            guard let urlImageString = imageData["urlImageString"] as? String else {
//                contentHandler(bestAttemptContent)
//                return
//            }
//            if let newsImageUrl = URL(string: urlImageString) {
//
//                guard let imageData = try? Data(contentsOf: newsImageUrl) else {
//                    contentHandler(bestAttemptContent)
//                    return
//                }
//                guard let attachment = UNNotificationAttachment.saveImageToDisk(fileIdentifier: "newsImage.jpg", data: imageData, options: nil) else {
//                    contentHandler(bestAttemptContent)
//                    return
//                }
//                bestAttemptContent.attachments = [ attachment ]
//            }
//        //    Messaging.serviceExtension().populateNotificationContent(self.bestAttemptContent!, withContentHandler: contentHandler)
//        }
//    }
//
//    override func serviceExtensionTimeWillExpire() {
//        // Called just before the extension will be terminated by the system.
//        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
//        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
//            contentHandler(bestAttemptContent)
//        }
//    }
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
         self.contentHandler = contentHandler
         bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

         guard let bestAttemptContent = bestAttemptContent else {
             return
         }
         guard let attachmentUrlString = request.content.userInfo["urlImageString"] as? String else {
             return
         }
         guard let url = URL(string: attachmentUrlString) else {
             return
         }

         URLSession.shared.downloadTask(with: url, completionHandler: { (optLocation: URL?, optResponse: URLResponse?, error: Error?) -> Void in
             if error != nil {
                 print("Download file error: \(String(describing: error))")
                 return
             }
             guard let location = optLocation else {
                 return
             }
             guard let response = optResponse else {
                 return
             }

             do {
                 let lastPathComponent = response.url?.lastPathComponent ?? ""
                 var attachmentID = UUID.init().uuidString + lastPathComponent

                 if response.suggestedFilename != nil {
                     attachmentID = UUID.init().uuidString + response.suggestedFilename!
                 }

                 let tempDict = NSTemporaryDirectory()
                 let tempFilePath = tempDict + attachmentID

                 try FileManager.default.moveItem(atPath: location.path, toPath: tempFilePath)
                 let attachment = try UNNotificationAttachment.init(identifier: attachmentID, url: URL.init(fileURLWithPath: tempFilePath))

                 bestAttemptContent.attachments.append(attachment)
             }
             catch {
                 print("Download file error: \(String(describing: error))")
             }

             OperationQueue.main.addOperation({() -> Void in
                 self.contentHandler?(bestAttemptContent);
             })
         }).resume()
     }

     override func serviceExtensionTimeWillExpire() {
         // Called just before the extension will be terminated by the system.
         // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
         if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
             contentHandler(bestAttemptContent)
         }
        }
    
}

//MARK: Extension for Notification Attachment
//extension UNNotificationAttachment {
//
//    static func saveImageToDisk(fileIdentifier: String, data: Data, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
//        let fileManager = FileManager.default
//        let folderName = ProcessInfo.processInfo.globallyUniqueString
//        let folderURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(folderName, isDirectory: true)
//
//        do {
//            try fileManager.createDirectory(at: folderURL!, withIntermediateDirectories: true, attributes: nil)
//            let fileURL = folderURL?.appendingPathComponent(fileIdentifier)
//            try data.write(to: fileURL!, options: [])
//            let attachment = try UNNotificationAttachment(identifier: fileIdentifier, url: fileURL!, options: options)
//            return attachment
//        } catch let error {
//            print("error \(error)")
//        }
//
//        return nil
//    }
//}
