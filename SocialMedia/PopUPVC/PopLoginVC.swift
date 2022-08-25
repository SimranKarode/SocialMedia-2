//
//  PopLoginVC.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 22/04/22.
//

import UIKit

protocol loginPopUpDelegate {
    func applicationLogin(selectType : String)
}

class PopLoginVC: UIViewController {
    
    @IBOutlet weak var lbl_titile: UILabel!
    
    @IBOutlet weak var no_btn: UIButton!
    
    @IBOutlet weak var yes_btn: UIButton!
    
    @IBOutlet weak var backview: CardView!
    
    var LoginprofileDelegate : loginPopUpDelegate?
//    var SideprofileDelegate : loginPopUpDelegate?
    var selectedLoginDelegate = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yes_btn.layer.borderWidth = 1.0
        yes_btn.layer.borderColor = UIColor.systemBlue.cgColor
        yes_btn.layer.cornerRadius = 10.0
        
        no_btn.layer.borderWidth = 1.0
        no_btn.layer.borderColor = UIColor.systemBlue.cgColor
        no_btn.layer.cornerRadius = 10.0
        
        backview.layer.cornerRadius = 10.0
        backview.layer.borderWidth = 1.0
        backview.layer.borderColor = UIColor.systemBlue.cgColor


        // Do any additional setup after loading the view.
    }
    
    @IBAction func no_BtnActn(_ sender: Any) {
        removeAnimate()
    }
    
    @IBAction func yes_BtnActn(_ sender: UIButton) {
        removeAnimate()
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
