//
//  LogoutViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 05/04/22.
//

import UIKit
protocol CustomePopUpDelegate {
    func applicationLogout(selectType : String)
    func referalCode(selectType : String)
}

class LogoutViewController: UIViewController {
    
    @IBOutlet weak var cancel_btn: UIButton!
    
    @IBOutlet weak var yes_btn: UIButton!
    @IBOutlet weak var lbl_name: UILabel!
    
    @IBOutlet weak var backview: CardView!
    
    var profileDelegate : CustomePopUpDelegate?
    var SideprofileDelegate : LogoutprofiletDelegate?
    var selectedLogoutType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yes_btn.layer.borderWidth = 1.0
        yes_btn.layer.borderColor = UIColor.systemBlue.cgColor
        yes_btn.layer.cornerRadius = 10.0
        
        cancel_btn.layer.borderWidth = 1.0
        cancel_btn.layer.borderColor = UIColor.systemBlue.cgColor
        cancel_btn.layer.cornerRadius = 10.0
        
        backview.layer.cornerRadius = 10.0
        backview.layer.borderWidth = 1.0
        backview.layer.borderColor = UIColor.systemBlue.cgColor

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel_BtnActn(_ sender: UIButton) {
        removeAnimate()
    }
    
    
    @IBAction func yes_BtnActn(_ sender: UIButton) {
        removeAnimate()
        UserDefaults.standard.set("false", forKey: "LoginStatus")
        UserDefaults.standard.set("true", forKey: "LogoutStatus")

        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let toggleVC = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as! MainTabBarViewController
        let navController = UINavigationController.init(rootViewController:toggleVC)
        let appDelegateP = UIApplication.shared
        appDelegateP.windows.first?.rootViewController = navController

        
    }
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
}
