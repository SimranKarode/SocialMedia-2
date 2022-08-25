//
//  ColourVc.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 07/04/22.
//

import UIKit

class ColourVc: UIViewController {

    @IBOutlet weak var colour_collectionview: UICollectionView!
    
    @IBOutlet weak var ok_BtnActn: UIButton!
    
    var selectedColourInfo : CreatePostPopUpDelegate?
    var overplayStr = ""
    var imageArray = ["1-1","1-2","1-3","1-4","1-5","1-6","1-7","1-8","1-9","1-10","1-11","1-12","1-13","1-14"]
//    var colorsArray = [".systemGreen", ".systemOrange", ".systemBlue",".systemPink", ".systemTeal", ".systemRed",".systemYellow", ".systemPurple", ".white",".black", ".systemFill", ".systemGray",".systemIndigo", ".systemBackground"]
    var colorsArray : [UIColor] = [.systemGreen, .systemOrange, .systemBlue,.systemPink, .systemTeal]
var  Colorcode =  ["B8255F","DB4035","FF9933","FAD000","AFB83B","7ECC49","299438","6ACCBC","158FAD","14AAF5","AF38EB","884DFF","4073FF","96C3EB"]
    
    var selectedImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        colour_collectionview.delegate = self
        colour_collectionview.dataSource = self
        
        colour_collectionview.register(UINib(nibName: "CollourViewCell", bundle: nil), forCellWithReuseIdentifier: "CollourViewCell")
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ok_btnActn(_ sender: UIButton) {
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
extension ColourVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        return imageArray.count
        return colorsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "CollourViewCell", for:  indexPath) as! CollourViewCell
        
//        cell.imgview.tag = indexPath.item
//        cell.imgview.image = UIImage(named: imageArray[indexPath.row])
        cell.imgview.image = selectedImage?.tintImage(with: colorsArray[indexPath.row])
        
        return cell
    }
//    @objc func imageClicked(_ sender : UIButton){
//
//
//    }
//
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let delegate = selectedColourInfo{
            if overplayStr == "Overplay"{
                let selectedColourCode = colorsArray[indexPath.item]
             //   let cell = collectionView.cellForItem(at: indexPath)
                //                cell?.backgroundColor = UIColor.cyan
                // print(cell.imgview.image[indexPath.item])
                
                NotificationCenter.default.post(name: Notification.Name("OverPlayNotificationIdentifier"), object: selectedColourCode)
                
                delegate.selectedOverplayDelegate(backGroundColor: selectedColourCode)
            }else{
                let selectedColourCode = Colorcode[indexPath.item]
                delegate.selectedColourInfoDelegte(backGroundColor: selectedColourCode)
                
            }
            
            
            
            
            //
            //               // let colorDef : UIColor = .red
            //                NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: selectedColourCode)
            //
            //                delegate.selectedOverplayDelegate(backGroundColor: selectedColourCode)
            //            }else{
            //                let selectedColourCode = Colorcode[indexPath.item]
            //                delegate.selectedColourInfoDelegte(backGroundColor: selectedColourCode)
            //
            //            }
        }
    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    //          return CGSize (width: 100, height: 100)
    //
    //        let cellsPerRow = 2
    //        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    //        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
    //        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
    //        return CGSize(width: 200, height: 200)
    //    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let cellsPerRow = 7
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        _ = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: 100, height: 100)
        
    }
    
}
