//
//  MainTabBarViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 21/04/22.
//

import Foundation
import UIKit

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    private var shouldSelectIndex = -1
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate = self

        setTabBarUI()
    }
    @objc func updateBackground(notification: NSNotification) {
        delegate = self
        // let isLight = notification.name == light
        //  let color = isLight ? UIColor.cyan : UIColor.red
        // view.backgroundColor = color
        setTabBarUI()
    }
    func setTabBarUI(){
       
        guard let items = tabBar.items else { return }
        items[0].title = "Home"
        items[1].title = "Premium"
        items[2].title = "CreatePost"
        items[3].title = "MyPost"
        items[4].title = "Settings"
        self.tabBar.unselectedItemTintColor = UIColor.darkGray
        self.tabBar.tintColor = UIColor.white
        self.tabBar.barTintColor = .black
        self.tabBar.isTranslucent = false

    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        tabBarController.tabBar.unselectedItemTintColor = UIColor.darkGray
        tabBarController.tabBar.tintColor = UIColor.white
        tabBarController.tabBar.barTintColor = .black
        
        shouldSelectIndex = tabBarController.selectedIndex
        return true
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        setTabBarUI()
        tabBarController.isEditing = true
        if shouldSelectIndex == tabBarController.selectedIndex {
            if let splitViewController = viewController as? UISplitViewController {
                if let navController = splitViewController.viewControllers[0] as? UINavigationController {
                    navController.popToRootViewController(animated: true)
                }
            }
        }else if tabBarController.selectedIndex == 2 {
//            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarcontroller") as! MainTabBarViewController
//            tabBarController.selectedIndex = 2
//            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ActivityViewController") as! ActivityViewController
//            if let navViewController = tabBarController.selectedViewController as? UINavigationController{
//                navViewController.setViewControllers([viewController], animated: true)
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = tabBarController
           // }
        }else if tabBarController.selectedIndex == 3 {
            //  lalertForLogOut()
        }else{
            
        }
    }
    //    func lalertForLogOut(){
    //        let logoutPopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogoutPopUpViewController") as! LogoutPopUpViewController
    //        logoutPopUpVC.isFromMainTab = "MainTab"
    //        logoutPopUpVC.logOutMainTabDelegate = self
    //        self.addChild(logoutPopUpVC)
    //        logoutPopUpVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    //        self.view.addSubview(logoutPopUpVC.view)
    //        logoutPopUpVC.didMove(toParent: self)
    //    }
    //    func logOut(){
    //        let defaults = UserDefaults.standard
    //        defaults.set(false , forKey: KFirstTime_Employee_Login)
    //        defaults.set("" , forKey: KLogin_User_Image)
    //        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    //        let landingVC = mainStoryboard.instantiateViewController(withIdentifier: "SelectLanguageVC") as! SelectLanguageVC
    //        landingVC.navFromLogin = "Profile"
    //        let navController = UINavigationController.init(rootViewController:landingVC)
    //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //        appDelegate.window?.rootViewController = navController
    //    }
    //    func mainTabApplicationLogout(selectedIndex : Int,selectType : String) {
    //        if selectType == "Yes" {
    //            logOut()
    //        }else{
    //            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    //            let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarcontroller") as! MainTabBarViewController
    //            tabBarController.selectedIndex = 0
    //            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "VisitorViewController") as! VisitorViewController
    //            if let navViewController = tabBarController.selectedViewController as? UINavigationController{
    //                navViewController.setViewControllers([viewController], animated: true)
    //                let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //                appDelegate.window?.rootViewController = tabBarController
    //            }
    //        }
    //    }
}
