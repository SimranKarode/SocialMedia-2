//
//  MyPostTabViewController.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 10/03/22.
//

import UIKit
protocol Deletefunctionality {
    func deleteDelegate(delete : Int)
}

class MyPostTabViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,Deletefunctionality {
   
    
    @IBOutlet weak var lbl_NavTitle: UILabel!
    @IBOutlet weak var back_Btn: UIButton!
    
    @IBOutlet weak var mypost_Collectionview: UICollectionView!
    
    let defaults = UserDefaults.standard
    var savedImageArray = [UIImage]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
       
//        lbl_NavTitle.isHidden = true
//        back_Btn.isHidden = true

        mypost_Collectionview.delegate = self
        mypost_Collectionview.dataSource = self
        mypost_Collectionview.collectionViewLayout.invalidateLayout()

        mypost_Collectionview.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        savedImageArray.removeAll()
        let images = UserDefaults.standard.allImageArray(forKey: "SavedImageArray")
        if images != nil{
                  savedImageArray = images!
                  print("savedImageArray count",savedImageArray.count)
                  print("savedImageArray",savedImageArray)
        }
      
    }
    
    func deleteDelegate(delete: Int) {
        savedImageArray.remove(at: delete)
        UserDefaults.standard.set(savedImageArray, forKey: "SavedImageArray")

        mypost_Collectionview.reloadData()
    }
    
    
    @IBAction func back_BtnActn(_ sender: UIButton) {
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
    
    
    
    // MARK:- CollectionView Delegate & DataSource Method
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedImageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imgview.image = savedImageArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
//    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
//    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{

        let cellsPerRow = 3
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth)

    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//         let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//         layout.sectionInset = UIEdgeInsets(top: 6, left: 15, bottom: 6, right: 15)
//         layout.minimumInteritemSpacing = 02
//         layout.minimumLineSpacing = 02
//         layout.invalidateLayout()
//         return CGSize(width: ((self.view.frame.width/2) - 6), height: ((self.view.frame.width / 2) - 6))
//         }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ////let selectedIndexName = savedImageArray[indexPath.item]
        let selectedImage = savedImageArray[indexPath.item]
//        print("BEFORe savedImageArrEy",savedImageArray.count)
//
//        savedImageArray.remove(at: indexPath.item) // "chimps"
//        UserDefaults.standard.set(savedImageArray, forKey: "SavedImageArray")

        print("OFTER savedImageArray",savedImageArray.count)
       // print(animals)           // ["cats", "dogs", "moose"]
        
//        mypost_Collectionview.reloadData()

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyBannerViewController") as! MyBannerViewController
        vc.deletefunctionality = self
        vc.selectedImage = selectedImage
        vc.selectedIndex = indexPath.item
        self.navigationController?.pushViewController(vc, animated: true)
       
    }
    
}


