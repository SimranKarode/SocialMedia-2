//
//  ViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 09/03/22.
//

import UIKit
import AFNetworking
import JGProgressHUD

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txf_email: UITextField!
    @IBOutlet weak var login_btn: UIButton!
    
    @IBOutlet weak var skip_btn: UIButton!
    
    
    @IBOutlet weak var backview: UIView!
    let hud = JGProgressHUD()
    var deviceToken = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        login_btn.layer.borderWidth = 1.0
        login_btn.layer.borderColor = UIColor.clear.cgColor
        login_btn.layer.cornerRadius = 10.0
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        
//        backview.layer.borderWidth = 1.0
//        backview.layer.borderColor = UIColor.red.cgColor
//        backview.layer.cornerRadius = 10.0
        //DeviceToken
        
        self.skip_btn.isHidden = true
        
       // let deviceTok = UserDefaults.standard.value(forKey:"DeviceToken") as? String ?? ""
        // deviceToken = deviceTok
        txf_email.delegate = self
//        txf_email.text = "66666666666"
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
          textField.resignFirstResponder()
            textField.endEditing(true)
            return true
        }
    
    
    @IBAction func back_BtnActn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func skip_BtnActn(_ sender: Any) {
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let toggleVC = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//        let navController = UINavigationController.init(rootViewController:toggleVC)
//        let appDelegateP = UIApplication.shared
//        appDelegateP.windows.first?.rootViewController = navController
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//        self.present(newViewController, animated: true, completion: nil)

    }
    
    
    
    
    
    
    @IBAction func login_BtnActn(_ sender: UIButton) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//
//           let nextViewController = storyBoard.instantiateViewController(withIdentifier: "tabBarcontroller") as! s
//
//           self.navigationController?.pushViewController(nextViewController, animated: true)
        
        if txf_email.text != "" {
            socialMedia()
        }else{

        }
    }
    func socialMedia() {
        let deviceTok = UserDefaults.standard.value(forKey:"DeviceToken") as? String ?? ""

        print("deviceTokendeviceToken",deviceTok)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let url = "https://socialmediaallinone.com/sma_admin/rest-api/v100/sendotp"

        let parameters:NSMutableDictionary = NSMutableDictionary()
        parameters["mobile_no"] = txf_email.text!
        parameters["device_token"] = deviceTok
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
            let user_id = result["user_id"] as? String
            let name = result["name"] as? String
            let email = result["email"] as? String
            let phone = result["phone"] as? String
            let image_url = result["image_url"] as? String
            let message = result["message"] as? String
            let otp = result["otp"] as? String
            
            
               if status == "success" {
                UserDefaults.standard.set("true", forKey: "LoginStatus")
                UserDefaults.standard.set("false", forKey: "LogoutStatus")
                   
                   let loginStatus = UserDefaults.standard.value(forKey:"LoginStatus") as? String
print("loginStatus",loginStatus)
                UserDefaults.standard.set(status, forKey: "status")
                UserDefaults.standard.set(user_id, forKey: "user_id")
                UserDefaults.standard.set(name, forKey: "name")
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(phone, forKey: "phone")
                UserDefaults.standard.set(image_url, forKey: "image_url")
                UserDefaults.standard.set(message, forKey: "message")
                UserDefaults.standard.set(otp, forKey: "otp")

                let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyOtpViewController") as! VerifyOtpViewController
                vc.yourMatchOTP = currentOTP!
                vc.loginType = status ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                UserDefaults.standard.set(txf_email.text!, forKey: "phone")

                let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyOtpViewController") as! VerifyOtpViewController
                vc.yourMatchOTP = currentOTP!
                vc.loginType = status ?? ""
                self.navigationController?.pushViewController(vc, animated: true)

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
    
}
   
