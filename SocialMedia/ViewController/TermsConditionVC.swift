//
//  TermsConditionVC.swift
//  SocialMedia
//
//  Created by Abdul on 04/05/22.
//

import UIKit
import WebKit

class TermsConditionVC: UIViewController {
    
    @IBOutlet weak var terms: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL (string: "https://socialmediaallinone.com/terms-conditions.html")
                let requestObj = URLRequest(url: url!)
        terms.load(requestObj)

        // Do any additional setup after loading the view.
    }
    

    @IBAction func back_BtnActn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
