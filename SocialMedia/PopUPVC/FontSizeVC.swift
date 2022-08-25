//
//  FontSizeVC.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 05/04/22.
//

import UIKit

class FontSizeVC: UIViewController {
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var ok_btn: UIButton!
    
    var selectedFont : CreatePostPopUpDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        slider.minimumValue = 20
        slider.maximumValue = 100
        slider.value = 20

        
        ok_btn.layer.borderWidth = 1.0
        ok_btn.layer.borderColor = UIColor.systemBlue.cgColor
        ok_btn.layer.cornerRadius = 10.0
        
    }
    
    @IBAction func sliderAuction(_ sender: UISlider) {
        
        if let delegate = selectedFont {
            delegate.fontSizeDelegate(forntSize: CGFloat(slider!.value))
        }
        
    }
    @IBAction func ok_BtnActn(_ sender: UIButton) {
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
