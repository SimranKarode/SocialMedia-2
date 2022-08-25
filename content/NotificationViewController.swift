//
//  NotificationViewController.swift
//  Content
//
//  Created by Abdul on 02/06/22.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        @available(iOSApplicationExtension 10.0, *)
        func didReceive(_ notification: UNNotification) {
            let content = notification.request.content

            if let imageURL = content.userInfo["urlImageString"] as? String {
                if let url = URL(string: imageURL) {
                    URLSession.downloadImage(atURL: url) { [weak self] (data, error) in
                        if let _ = error {
                            return
                        }
                        guard let data = data else {
                            return
                        }
                        DispatchQueue.main.async {
                            self?.imageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
        
    }

    extension URLSession {
        
        class func downloadImage(atURL url: URL, withCompletionHandler completionHandler: @escaping (Data?, NSError?) -> Void) {
            let dataTask = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                completionHandler(data, nil)
            }
            dataTask.resume()
        }
    }
