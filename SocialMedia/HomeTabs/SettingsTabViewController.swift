//
//  SettingsTabViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 10/03/22.
//

import UIKit
protocol LogoutprofiletDelegate {
    func applicationLogout(selectType : String)
}

class SettingsTabViewController: UIViewController,LogoutprofiletDelegate {
    func applicationLogout(selectType: String) {
        
    }
    
    func applicationLogin(selectType: String) {
        
    }
    
    
    
    @IBOutlet weak var back_Btn: UIButton!
    
    @IBOutlet weak var lbl_NavTitle: UILabel!
    
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var settings_Tableview: UITableView!
    
    var selectedLogoutType = ""
    var loginstatus = ""
    
    var MainArrayList = ["Privacy Policy","Share","Rate Us","Teams & Condition","Update Business Profile","Contact US","Log Out"]
    var ImagemainArrayList = ["privacy","share","Star","term","updatebusiness","updatebusiness","logout"]
    
    var MainArrayList2 = ["Privacy Policy","Share","Rate Us","Teams & Condition","Update Business Profile","Login"]
    var ImagemainArrayList2 = ["privacy","share","Star","term","updatebusiness","logout"]
    
    var documentInteractionController:UIDocumentInteractionController!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //oginstatus = UserDefaults.standard.value(forKey:"LoginStatus") as? String
        
//        lbl_NavTitle.isHidden = true
//        back_Btn.isHidden = true 

        settings_Tableview.delegate = self
        settings_Tableview.dataSource =  self

        settings_Tableview.register( UINib(nibName:  "ListTableViewCell", bundle: nil), forCellReuseIdentifier:  "ListTableViewCell")
        
        imgview.layer.borderWidth = 1
        imgview.layer.masksToBounds = false
        imgview.layer.borderColor = UIColor.black.cgColor
        imgview.layer.cornerRadius = imgview.frame.width/2
        imgview.clipsToBounds = true

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        guard let login = UserDefaults.standard.string(forKey: "LoginStatus") else { return }
        loginstatus = login
        if loginstatus == "true"{
            let imgurl = UserDefaults.standard.object(forKey: "image_url") as? String
            if imgurl != nil {
                imgview.sd_setImage(with:URL(string: imgurl!) , placeholderImage: #imageLiteral(resourceName: "latestst123"))

            }else{
                imgview.image = UIImage(named: "latestst123")
            }
        }else{
            imgview.image = UIImage(named: "latestst123")
        }
        
    }
    

    @IBAction func back_BtnActn(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
//        self.navigationController?.popToRootViewController(animated: true)
             let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                     let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as! MainTabBarViewController
                     tabBarController.selectedIndex = 0
                     let viewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                     if let navViewController = tabBarController.selectedViewController as? UINavigationController{
                         navViewController.setViewControllers([viewController], animated: true)
                      //   let appDelegateP = UIApplication.shared.delegate as! AppDelegate
                         let appDelegateP = UIApplication.shared
                         appDelegateP.windows.first?.rootViewController = tabBarController
                     }
    }
    

}
extension SettingsTabViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loginstatus == "true"{
            return self.MainArrayList.count
        }else{
            return self.MainArrayList2.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        if loginstatus == "true"{
            listTableViewCell.lbl_nameList.text = MainArrayList[indexPath.row]
            listTableViewCell.imageview.image = UIImage(named:ImagemainArrayList[indexPath.row])
        }else{
            listTableViewCell.lbl_nameList.text = MainArrayList2[indexPath.row]
            listTableViewCell.imageview.image = UIImage(named:ImagemainArrayList2[indexPath.row])
        }
        return listTableViewCell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if loginstatus == "true" {
            if indexPath.item == 0 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPoliceyViewController") as! PrivacyPoliceyViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.item == 1  {
                self.Share2()
            }else if indexPath.item == 2  {
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TestedViewController") as! TestedViewController
                self.navigationController?.pushViewController(vc, animated: true)
//                CreatePostVC,OtherThenViewController/TestViewController
                
            }else if indexPath.item == 3 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsConditionVC") as! TermsConditionVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.item == 4 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateBussinessProfileViewController") as! UpdateBussinessProfileViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if indexPath.item == 5 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactUSViewController") as! ContactUSViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else{
                let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogoutViewController") as! LogoutViewController
                self.addChild(logoutPopUpVC)
                logoutPopUpVC.SideprofileDelegate = self
                logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.view.addSubview(logoutPopUpVC.view)
                logoutPopUpVC.didMove(toParent: self)
//                alertForLogout()
            }
            
        }else{
            
            if indexPath.item == 0 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPoliceyViewController") as! PrivacyPoliceyViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.item == 1  {
                //
                let someText:String = "Social Media"
                let objectsToShare:URL = URL(string: "https://www.social medi.in/socialmedia/")!
                let sharedObjects:[AnyObject] = [objectsToShare as AnyObject,someText as AnyObject]
                let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                self.present(activityViewController, animated: true, completion: nil)
            }else if indexPath.item == 2  {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SampleViewController") as! SampleViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.item == 3 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactUSViewController") as! ContactUSViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.item == 4 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateBussinessProfileViewController") as! UpdateBussinessProfileViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                
                
                
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MySubscriptionViewController") as! MySubscriptionViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
//                UserDefaults.standard.set("false", forKey: "LoginStatus")
//                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let toggleVC = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//                let navController = UINavigationController.init(rootViewController:toggleVC)
//                let appDelegateP = UIApplication.shared
//                appDelegateP.windows.first?.rootViewController = navController
//                alertForLogin()
            }
        }
        func applicationLogout(selectType : String) {
            print("selectType",selectType)
            logOut()
        }
        
        func logOut(){
            //            UserDefaults.standard.set("false", forKey: "LoginStatus")
            //            UserDefaults.standard.removeObject(forKey:"user_id")
            //            UserDefaults.standard.removeObject(forKey:"name")
            //            UserDefaults.standard.removeObject(forKey:"email")
            //            UserDefaults.standard.removeObject(forKey:"phone")
            //            UserDefaults.standard.removeObject(forKey:"image_url")
            //            UserDefaults.standard.removeObject(forKey:"message")
            //            UserDefaults.standard.removeObject(forKey:"otp")
            //            let homeVC = LogoutViewController.init(nibName: "LogoutViewController", bundle: nil)
            //            self.navigationController?.pushViewController(homeVC, animated: true)
            
            UserDefaults.standard.set("false", forKey: "LoginStatus")
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let toggleVC = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            let navController = UINavigationController.init(rootViewController:toggleVC)
            let appDelegateP = UIApplication.shared
            appDelegateP.windows.first?.rootViewController = navController
        }
        
    }
    func Share2(){
        let someText:String = "Social Media"
        let objectsToShare:URL = URL(string: "https://www.sterlex.in/strlex/")!
        let sharedObjects:[AnyObject] = [objectsToShare as AnyObject,someText as AnyObject]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    func alertForLogout(){
        // create the alert
        
        let alert = UIAlertController(title: "Social Media!", message: "Are you sure want to Logout now?", preferredStyle: .alert)
            
             let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                 let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let toggleVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                 let navController = UINavigationController.init(rootViewController:toggleVC)
                 let appDelegateP = UIApplication.shared
                 appDelegateP.windows.first?.rootViewController = navController

             })
             alert.addAction(ok)
             let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
                 
                 
             })
             alert.addAction(cancel)
             DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
        })
    }
    func alertForLogin(){
        // create the alert
        
        let alert = UIAlertController(title: "Social Media!", message: "Are you sure want to Logout now?", preferredStyle: .alert)
            
             let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                 let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let toggleVC = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                 let navController = UINavigationController.init(rootViewController:toggleVC)
                 let appDelegateP = UIApplication.shared
                 appDelegateP.windows.first?.rootViewController = navController

             })
             alert.addAction(ok)
             let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
                 
                 
             })
             alert.addAction(cancel)
             DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
        })
    }
}
