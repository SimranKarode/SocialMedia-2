//
//  alertClass.swift
//  jewelmaxMainProject
//
//  Created by ABDUL KADIR ANSARI on 10/02/21.
//  Copyright © 2021 ABDUL KADIR ANSARI. All rights reserved.
//

import Foundation
import UIKit

let KFirstTime_Login = "KFirstTime_Login"

let KDeviceToken = "KDeviceToken"

let KReferal_Code = "KReferal_Code"

extension UIViewController{

    func showAlert(alertTitle : String, message : String)
    {
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            //            print("You've pressed OK Button")
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // **  MARK ALERT CALLBACK OPTION

    func showAlertCallBack(alertTitle : String, message : String, result:@escaping (String)->()){
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            
            result("1")
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
   // **  MARK ALERT WITH OPTION
    func showAlertWithOption(Title : String, message : String, result:@escaping (String)->())
    {
        let alertController = UIAlertController(title: Title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let OKAction = UIAlertAction(title: "YES", style: .default) { action in
            
            result("1")
        }
        
        let CancelAction = UIAlertAction(title: "NO", style: .cancel) { action in
            
            result("0")
        }
        
        alertController.addAction(CancelAction)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
