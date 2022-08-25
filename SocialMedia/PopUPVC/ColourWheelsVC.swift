//
//  ColourWheelsVC.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 09/04/22.
//

import Foundation
import UIKit

class ColourWheelsVC: UIViewController,ColorDateDelegate {
    
   
    @IBOutlet weak var colorPicker: ColorPickerView!
    
    @IBOutlet weak var ok_btn: UIButton!
    // Init ColorPicker with yellow
    var selectedColor: UIColor = UIColor.black
    var colorwheels : CreatePostPopUpDelegate?
var postTypeVC = ""
    let colorPickerView = ColorPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifierForTextColor"), object: nil)
        
        
        
        if postTypeVC == "CreatePostVC" {
            colorPickerView.onColorDidChange = { [weak self] color in
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: self?.colorPickerView)
                        // use picked color for your needs here...
                    }
                }
        }else{
            colorPickerView.onColorDidChange = { [weak self] color in
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: self?.colorPickerView)
                    // use picked color for your needs here...
                }
            }
        }
    
        
        
    }
    
//    //MARK: - - - - - Method for receiving Data through Post Notificaiton - - - - -
//        @objc func methodOfReceivedNotification(notification: Notification) {
//            print("Value of notification : ", notification.object ?? "")
//            //view.backgroundColor = (notification.object! as! UIColor)
//
//        }
    func colorData(color: UIColor) {
//         let selectedColor = colorPicker.color
        self.view.backgroundColor = color
        
    }
    
    
    @IBAction func ok_BtnActn(_ sender: Any) {

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
