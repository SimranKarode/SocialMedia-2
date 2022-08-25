//
//  ChangeBGCVC.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 05/04/22.
//

import UIKit

class ChangeBGCVC: UIViewController {

    @IBOutlet weak var backview: CardView!
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_percentage: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    
    @IBOutlet weak var btn_1: UIButton!
    @IBOutlet weak var btn_2: UIButton!
    @IBOutlet weak var btn_3: UIButton!
    @IBOutlet weak var btn_4: UIButton!
    @IBOutlet weak var btn_5: UIButton!
    @IBOutlet weak var btn_6: UIButton!
    @IBOutlet weak var btn_7: UIButton!
    
    @IBOutlet weak var btn_8: UIButton!
    @IBOutlet weak var btn_9: UIButton!
    @IBOutlet weak var btn_10: UIButton!
    @IBOutlet weak var btn_11: UIButton!
    @IBOutlet weak var btn_12: UIButton!
    @IBOutlet weak var btn_13: UIButton!
    @IBOutlet weak var btn_14: UIButton!
    
    @IBOutlet weak var ok_btn: UIButton!
    
    var SelectedColour  = ""
    
    
    var changeBGCVC : CreatePostPopUpDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        btn_1.layer.borderWidth = 1
        btn_1.layer.masksToBounds = false
        btn_1.layer.borderColor = UIColor.black.cgColor
        btn_1.layer.cornerRadius = btn_1.frame.height/2
        btn_1.clipsToBounds = true
        
        btn_2.layer.borderWidth = 1
        btn_2.layer.masksToBounds = false
        btn_2.layer.borderColor = UIColor.black.cgColor
        btn_2.layer.cornerRadius = btn_2.frame.height/2
        btn_2.clipsToBounds = true
        
        btn_3.layer.borderWidth = 1
        btn_3.layer.masksToBounds = false
        btn_3.layer.borderColor = UIColor.black.cgColor
        btn_3.layer.cornerRadius = btn_3.frame.height/2
        btn_3.clipsToBounds = true
        
        btn_4.layer.borderWidth = 1
        btn_4.layer.masksToBounds = false
        btn_4.layer.borderColor = UIColor.black.cgColor
        btn_4.layer.cornerRadius = btn_1.frame.height/2
        btn_4.clipsToBounds = true
        
        btn_5.layer.borderWidth = 1
        btn_5.layer.masksToBounds = false
        btn_5.layer.borderColor = UIColor.black.cgColor
        btn_5.layer.cornerRadius = btn_5.frame.height/2
        btn_5.clipsToBounds = true
        
        btn_6.layer.borderWidth = 1
        btn_6.layer.masksToBounds = false
        btn_6.layer.borderColor = UIColor.black.cgColor
        btn_6.layer.cornerRadius = btn_6.frame.height/2
        btn_6.clipsToBounds = true
        
        btn_7.layer.borderWidth = 1
        btn_7.layer.masksToBounds = false
        btn_7.layer.borderColor = UIColor.black.cgColor
        btn_7.layer.cornerRadius = btn_1.frame.height/2
        btn_7.clipsToBounds = true
        
        btn_8.layer.borderWidth = 1
        btn_8.layer.masksToBounds = false
        btn_8.layer.borderColor = UIColor.black.cgColor
        btn_8.layer.cornerRadius = btn_8.frame.height/2
        btn_8.clipsToBounds = true
        
        btn_9.layer.borderWidth = 1
        btn_9.layer.masksToBounds = false
        btn_9.layer.borderColor = UIColor.black.cgColor
        btn_9.layer.cornerRadius = btn_9.frame.height/2
        btn_9.clipsToBounds = true
        
        btn_10.layer.borderWidth = 1
        btn_10.layer.masksToBounds = false
        btn_10.layer.borderColor = UIColor.black.cgColor
        btn_10.layer.cornerRadius = btn_3.frame.height/2
        btn_10.clipsToBounds = true
        
        btn_11.layer.borderWidth = 1
        btn_11.layer.masksToBounds = false
        btn_11.layer.borderColor = UIColor.black.cgColor
        btn_11.layer.cornerRadius = btn_11.frame.height/2
        btn_11.clipsToBounds = true
        
        btn_12.layer.borderWidth = 1
        btn_12.layer.masksToBounds = false
        btn_12.layer.borderColor = UIColor.black.cgColor
        btn_12.layer.cornerRadius = btn_12.frame.height/2
        btn_12.clipsToBounds = true
        
        btn_13.layer.borderWidth = 1
        btn_13.layer.masksToBounds = false
        btn_13.layer.borderColor = UIColor.black.cgColor
        btn_13.layer.cornerRadius = btn_13.frame.height/2
        btn_13.clipsToBounds = true
        
        btn_14.layer.borderWidth = 1
        btn_14.layer.masksToBounds = false
        btn_14.layer.borderColor = UIColor.black.cgColor
        btn_14.layer.cornerRadius = btn_14.frame.height/2
        btn_14.clipsToBounds = true
        
        ok_btn.layer.borderWidth = 1.0
        ok_btn.layer.borderColor = UIColor.black.cgColor
        ok_btn.layer.cornerRadius = 10.0
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        
        //        colorSquare.layer.borderColor = UIColor.black.cgColor
        //        colorSquare.backgroundColor = UIColor.purple
        
        let defaults = UserDefaults.standard
        slider.value = 50.0
        slider.value = defaults.float(forKey: "red")
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if(segue.identifier == "openColor") {
//           let newViewController = segue.destination as UIViewController
//           newViewController.view.backgroundColor = colorSquare.backgroundColor
       }
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
    @IBAction func Ok_BtnActn(_ sender: UIButton) {
        removeAnimate()
    }
    
    @IBAction func btn1_Actn(_ sender: UIButton) {
        yourColorData(yourColor: .red)
    }
    
    
    @IBAction func btn2_Actn(_ sender: UIButton) {
        yourColorData(yourColor: .purple)

    }
    
    @IBAction func btn3_Actn(_ sender: UIButton) {
        yourColorData(yourColor: .orange)

    }
    
    @IBAction func btn4_Actn(_ sender: UIButton) {
        yourColorData(yourColor: .green)
    }
    
    @IBAction func btn5_Actn(_ sender: UIButton) {
        yourColorData(yourColor: .yellow)
        
    }
    
    @IBAction func btn6_Actn(_ sender: UIButton) {
        yourColorData(yourColor: .blue)
    }
    
    @IBAction func btn7_Actn(_ sender: Any) {
        yourColorData(yourColor: .black)
        
    }
    
    @IBAction func btn8_Actn(_ sender: UIButton) {
        yourColorData(yourColor: .white)
        
    }
    
    @IBAction func btn9_Actn(_ sender: UIButton) {
        yourColorData(yourColor: .systemPink)
        
    }
    
    @IBAction func btn10_Actn(_ sender: UIButton) {
        yourColorData(yourColor: .systemGray)
    }
    
    @IBAction func btn11_Actn(_ sender: UIButton) {
        yourColorData(yourColor: .darkGray)

    }
    
    
    @IBAction func btn12_Actn(_ sender: UIButton) {
        yourColorData(yourColor: .systemBlue)
    }
    
    @IBAction func btn13_Actn(_ sender: UIButton) {
        yourColorData(yourColor: .systemTeal)
    }
    
    @IBAction func btn14_Actn(_ sender: UIButton) {
        yourColorData(yourColor: .systemGreen)
    }
    
    func yourColorData(yourColor:UIColor){
        if let delegate = changeBGCVC {
            delegate.selectedColorDelegate(backGroundColor: yourColor)
        }
    }
}
