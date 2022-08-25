//
//  SelectBGIVC.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 05/04/22.
//

import UIKit

class SelectBGIVC: UIViewController {

    @IBOutlet weak var ok_btn: UIButton!
    @IBOutlet weak var lbl_title: UILabel!
    
    
    
      
    @IBOutlet weak var imgbackground_collectionview: UICollectionView!
    var imageArray = ["pf_s1","pf_s2","pf_s3","pf_s4","pf_s5","pf_s10","pf_s11","pf_s12","pf_s13","pf_s14","pf_s15","pf_s16","pf_s17","pf_s18","pf_s19","pf_s20","pf_s21","pf_s22","pf_s23","pf_s24","pf_s25","pf_s26","pf_s27","pf_s28","pf_s29","pf_s30","pf_s31","pf_s32","pf_s33","pf_s34","pf_s35","pf_s36","pf_s37","pf_s38","pf_s39","pf_s40","pf_s41","pf_s42","pf_s43","pf_s44","pf_s45","frame_1","frame_2","frame_3","frame_35","frame_42","frame_51","frame_52","frame_59"]
    
    var backGroundImage : CreatePostPopUpDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        ok_btn.layer.borderWidth = 1.0
        ok_btn.layer.borderColor = UIColor.systemBlue.cgColor
        ok_btn.layer.cornerRadius = 10.0
        
        imgbackground_collectionview.delegate = self
        imgbackground_collectionview.dataSource = self
        
        imgbackground_collectionview.register(UINib(nibName: "CollourViewCell", bundle: nil), forCellWithReuseIdentifier: "CollourViewCell")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func ok_BtnActn(_ sender: UIButton) {
        self.removeAnimate()
    }
}
extension SelectBGIVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "CollourViewCell", for:  indexPath) as! CollourViewCell
        
        cell.imgview.tag = indexPath.item
        cell.imgview.image = UIImage(named: imageArray[indexPath.row])
        
       
//        cell.imgview.tag.addTarget(self, action: #selector(imageClicked(_:)), for: .touchUpInside)
                
        return cell
    }
//    @objc func imageClicked(_ sender : UIButton){
//
//
//    }
//
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = imageArray[indexPath.row]
        if let delegate = backGroundImage {
            delegate.selectedImageDelegate(image: selectedImage)
        }
        removeAnimate()

//        if indexPath.item == 0 {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubMoreViewController") as! SubMoreViewController
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
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
//
//        let cellsPerRow = 2
//        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
//        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
//        return CGSize(width: itemWidth, height: 100)
        
                return CGSize(width: 100, height: 100)
        
    }
    
}
