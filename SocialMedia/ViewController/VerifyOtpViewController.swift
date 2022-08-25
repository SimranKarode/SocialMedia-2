//
//  VerifyOtpViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 04/04/22.
//

import UIKit
import AFNetworking
import JGProgressHUD

class VerifyOtpViewController: UIViewController {
    
    
    @IBOutlet weak var verified_Btn: UIButton!
    
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var txf_one: UITextField!
    @IBOutlet weak var txf_two: UITextField!
    @IBOutlet weak var txf_three: UITextField!
    @IBOutlet weak var txf_four: UITextField!
    
    @IBOutlet weak var resend_otpBtn: UIButton!
    
        var first = false
        var second = false
        var third = false
        var fourth = false
        
        var removeFirst = false
        var removeSecond = false
        var removeThird = false
        var removeFourth = false
        
        var firstString = ""
        var secondString = ""
        var thirdString = ""
        var fourthString = ""
    
    var timer : Timer? = nil
    var secondsRemaining = 60
    var yourMatchOTP = ""
    var loginType = ""

    let hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        verified_Btn.layer.cornerRadius = 10
        verified_Btn.layer.borderColor = UIColor.clear.cgColor
        verified_Btn.layer.borderWidth = 1.0
        
        txf_one.delegate = self
        txf_two.delegate = self
        txf_three.delegate = self
        txf_four.delegate = self
        self.timerMethod()
        // Do any additional setup after loading the view.
    }
    func timerMethod(){
       // lbl_time.isHidden = false

          timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
       }
    @objc func updateCounter(){
        if secondsRemaining >= 0 {
            if secondsRemaining == 60 {
                lbl_time.isHidden = true
                print("0 : \(00)")
                lbl_time.text =  "0 :\(00)"
            }else{
                print("secondsRemaining 0 : \(secondsRemaining)")
                lbl_time.text =  "0 : \(secondsRemaining)"
                lbl_time.isHidden = false

                if secondsRemaining == 0 {
                    lbl_time.isHidden = true
//                    userInteractionActive()
                }else{
//                    userInteractionDeActive()
                }
            }
            secondsRemaining -= 1
        }
    }

    @IBAction func verified_BtnActn(_ sender: Any) {
        
        let yourOTP = firstString + "" + secondString + "" + thirdString + "" + fourthString
        if yourMatchOTP == yourOTP {
            //
            if loginType == "success" {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "tabBarController") as! MainTabBarViewController
                
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            timer?.invalidate()
            
        }else{
            print("ERROR")
        }
        //
        
    }
    
    
    @IBAction func resendotp_BtnActn(_ sender: UIButton) {
        
        txf_one.text = ""
        txf_two.text = ""
        txf_three.text = ""
        txf_four.text = ""
        
        firstString = ""
        secondString = ""
        thirdString = ""
        fourthString = ""
        
        txf_one.endEditing(true)
        txf_two.endEditing(true)
        txf_three.endEditing(true)
        txf_four.endEditing(true)

        socialMedia1()
    }
    
    func socialMedia1() {
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        let parameters:NSMutableDictionary = NSMutableDictionary()
        parameters["mobile_no"] = "9951518057"
        let url = "https://socialmediaallinone.com/sma_admin/rest-api/v100/sendotp"
        
        //
        print(url)
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        
        manager.post(url, parameters: parameters, headers: ["API-KEY" : "8e90d71140a94bb"], constructingBodyWith: { (formData : AFMultipartFormData!) in
            
        }, progress: nil, success: { [self] (operation,LoginResponse) in
            print(LoginResponse as Any)
            let result = LoginResponse as! NSDictionary
            
            let yourName = result["email"] as? String
            let currentOTP = result["otp"] as? String
            let status = result["status"] as? String
            
            print("yourNameyourName",yourName)
            
            self.yourMatchOTP = currentOTP ?? ""
            let otp = result["otp"] as? String
      
            UserDefaults.standard.set(status, forKey: "status")
            UserDefaults.standard.set(otp, forKey: "otp")
            
            if status == "success" {
                self.secondsRemaining = 10
                self.timerMethod()
            }else{
                
            }
            self.hud.dismiss()
            
        }) { (operation, error) in
            print("Error: " + error.localizedDescription)
            self.hud.dismiss()
            self.loginShowAlert(alertTitle: "Alert!", message: error.localizedDescription)
        }        //  }
        
    }
    
    func loginShowAlert(alertTitle : String, message : String)
    {
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            //            print("You've pressed OK Button")
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

    
    
    @IBAction func back_BtnActn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
extension VerifyOtpViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           // On inputing value to textfield
           if ((textField.text?.count)! < 1  && string.count > 0){
               if(textField == txf_one)
               {
                txf_one.becomeFirstResponder()
                   first = true
               }
               if(textField == txf_two)
               {
                txf_two.becomeFirstResponder()
                   second = true
               }
               if(textField == txf_three)
               {
                txf_three.becomeFirstResponder()
                   third = true
               }
               if(textField == txf_four)
               {
                txf_four.becomeFirstResponder()
                   fourth = true
               }
               if first == true {
                   textField.text = string
                txf_one.textColor = UIColor(red: 21.0/255.0, green: 48.0/255.0, blue: 114.0/255.0, alpha: 1.0)
                   // first_TF.backgroundColor =  UIColor(red: 21.0/255.0, green: 48.0/255.0, blue: 114.0/255.0, alpha: 1.0)
                   firstString = textField.text!
                txf_two.becomeFirstResponder()
                   first = false
               }
               if second == true {
                   textField.text = string
                txf_two.textColor = UIColor(red: 21.0/255.0, green: 48.0/255.0, blue: 114.0/255.0, alpha: 1.0)
                   // second_TF.backgroundColor =  UIColor(red: 21.0/255.0, green: 48.0/255.0, blue: 114.0/255.0, alpha: 1.0)
                   secondString = textField.text!
                txf_three.becomeFirstResponder()
                   second = false
               }
               if third == true {
                txf_three.text = string
                txf_three.textColor = UIColor(red: 21.0/255.0, green: 48.0/255.0, blue: 114.0/255.0, alpha: 1.0)
                   // third_TF.backgroundColor =  UIColor(red: 21.0/255.0, green: 48.0/255.0, blue: 114.0/255.0, alpha: 1.0)
                   thirdString = textField.text!
                txf_four.becomeFirstResponder()
                   third = false
               }
               if fourth == true {
                textField.text = string
                txf_four.textColor = UIColor(red: 21.0/255.0, green: 48.0/255.0, blue: 114.0/255.0, alpha: 1.0)
                   //  fourth_TF.backgroundColor =  UIColor(red: 21.0/255.0, green: 48.0/255.0, blue: 114.0/255.0, alpha: 1.0)
                   fourthString = textField.text!
                   fourth = false
               }
               return false
           }
           else if ((textField.text?.count)! >= 1  && string.count == 0){
               // on deleting value from Textfield
               if(textField == txf_one)
               {
                   txf_one.backgroundColor =  UIColor.white
                   txf_one.becomeFirstResponder()
                   removeFirst = true
               }
               if(textField == txf_two)
               {
                   txf_two.backgroundColor =  UIColor.white
                   txf_two.becomeFirstResponder()
                   removeSecond = true
               }
               if(textField == txf_three)
               {
                   txf_three.backgroundColor =  UIColor.white
                txf_three.becomeFirstResponder()
                   removeThird = true
               }
               
               if(textField == txf_four)
               {
                   txf_four.backgroundColor =  UIColor.white
                   txf_four.becomeFirstResponder()
                   removeFourth = true
               }
               
               if removeFirst == true {
                   txf_one.placeholder = "0"
                   textField.text = ""
                   firstString = textField.text!
                   removeFirst = false
               }
               if removeSecond == true {
                   txf_two.placeholder = "0"
                   txf_two.becomeFirstResponder()
                   textField.text = ""
                   secondString = textField.text!
                   removeSecond = false
               }
               if removeThird == true {
                   txf_three.placeholder = "0"
                   txf_two.becomeFirstResponder()
                   textField.text = ""
                   thirdString = textField.text!
                   removeThird = false
               }
               if removeFourth == true {
                   txf_four.placeholder = "0"
                   txf_three.becomeFirstResponder()
                   textField.text = ""
                   fourthString = textField.text!
                   removeFourth = false
               }
               // textField.text = ""
               return false
           }
           else if ((textField.text?.count)! >= 1  )
           {
               textField.text = string
               return false
           }
           return true
       }
     
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
           
           print("textFieldShouldEndEditing")
           
           return true
       }
}
