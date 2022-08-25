//
//  MoreViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 05/04/22.
//

import UIKit
import JGProgressHUD


class MoreViewController: UIViewController {
    
    @IBOutlet weak var back_btn: UIButton!
    @IBOutlet weak var lbl_NavTitle: UILabel!
    @IBOutlet weak var more_collectionview: UICollectionView!
    
    var videosFromJsonVO:[VideosJsonVO] = []
    var Selectedlable_title = ""
    
    var loginStatus = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        
        guard let login = UserDefaults.standard.string(forKey: "LoginStatus") else { return }
        loginStatus = login

        
        self.lbl_NavTitle.text = Selectedlable_title
        more_collectionview.delegate = self
        more_collectionview.dataSource = self
        
        more_collectionview.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        
        
    }
    

    @IBAction func back_BtnActn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
//
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
              let toggleVC = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as! MainTabBarViewController
              let navController = UINavigationController.init(rootViewController:toggleVC)
              let appDelegateP = UIApplication.shared
              appDelegateP.windows.first?.rootViewController = navController
    }
    

}

extension MoreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videosFromJsonVO.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "ImageCollectionViewCell", for:  indexPath) as! ImageCollectionViewCell
        
//        cell.backview.layer.cornerRadius = 6
//        cell.backview.layer.borderWidth = 1
//        cell.backview.layer.borderColor = UIColor.systemGray.cgColor
        let yourData = self.videosFromJsonVO[indexPath.item]
        cell.imgview.sd_setImage(with:URL(string: yourData.poster_url ?? "") , placeholderImage: #imageLiteral(resourceName: "latestst123"))

        return cell
    }
//    @objc func imageClicked(_ sender : UIButton){
//
//      
//    }
//
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let yourData = self.videosFromJsonVO[indexPath.item]
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubMoreViewController") as! SubMoreViewController
//        vc.selectedVideoId = yourData.videos_id ?? ""
//        //        vc.selectededTitle = yourData.title ?? ""
//        vc.isFromSubMore = "More"
//        self.navigationController?.pushViewController(vc, animated: true)
        
        if loginStatus == "false"{
            alertForLogin()
        }else{
            let yourData = self.videosFromJsonVO[indexPath.item]
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubMoreViewController") as! SubMoreViewController
            vc.selectedVideoId = yourData.videos_id ?? ""
            //        vc.selectededTitle = yourData.title ?? ""
            vc.isFromSubMore = "More"
            vc.isRootFrom = Selectedlable_title
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func alertForLogin(){
        // create the alert
        
        let alert = UIAlertController(title: "Social Media!", message: "Are you sure want to login now?", preferredStyle: .alert)
            
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

         let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
         layout.sectionInset = UIEdgeInsets(top: 6, left: 15, bottom: 6, right: 15)
         layout.minimumInteritemSpacing = 02
         layout.minimumLineSpacing = 02
         layout.invalidateLayout()
         return CGSize(width: ((self.view.frame.width/2) - 6), height: ((self.view.frame.width / 2) - 6))
         }
    
}
