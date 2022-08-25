//
//  PrivacyPoliceyViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 04/04/22.
//

import UIKit
import WebKit
class PrivacyPoliceyViewController: UIViewController {

    @IBOutlet weak var Navigiation_Btn: UIButton!
    
    @IBOutlet weak var lbl_NavigationTitle:UILabel!
    
    @IBOutlet weak var Privacey: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL (string: "https://socialmediaallinone.com/privacy-policy.html")
                let requestObj = URLRequest(url: url!)
        Privacey.load(requestObj)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back_BtnActn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
//

}
