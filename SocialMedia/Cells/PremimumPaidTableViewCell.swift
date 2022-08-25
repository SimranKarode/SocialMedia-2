//
//  PremimumPaidTableViewCell.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 04/04/22.
//

import UIKit
import ObjectMapper
import AFNetworking
import SDWebImage
import JGProgressHUD

protocol CollectionViewCellDelegate: AnyObject {
    func collectionView(collectionviewcell: DummyPrimiumCell?, section: Int,index: Int, didTappedInTableViewCell: PremimumPaidTableViewCell)
    // other delegate methods that you can define to perform action in viewcontroller
}

class PremimumPaidTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionview_Premiumcell: UICollectionView!
    
    @IBOutlet weak var lbl_selectName: UILabel!
    
    
    weak var cellDelegate: CollectionViewCellDelegate?
   // var rowWithColors: [CollectionViewCellModel]?

    var filtered:[PakResultVO] = []

    var imageArray = ["sliver_back","red_back","sliver_back","orange_back"]

        override func awakeFromNib() {
            super.awakeFromNib()
            backgroundColor = UIColor.clear
            self.lbl_selectName.textColor = UIColor.black
            
            // TODO: need to setup collection view flow layout
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = CGSize(width: 220, height: 360)
            flowLayout.minimumLineSpacing = 2.0
            flowLayout.minimumInteritemSpacing = 5.0
            self.collectionview_Premiumcell.collectionViewLayout = flowLayout
            self.collectionview_Premiumcell.showsHorizontalScrollIndicator = false
            
            // Comment if you set Datasource and delegate in .xib
            self.collectionview_Premiumcell.dataSource = self
            self.collectionview_Premiumcell.delegate = self
            
            // Register the xib for collection view cell
            let cellNib = UINib(nibName: "DummyPrimiumCell", bundle: nil)
            self.collectionview_Premiumcell.register(cellNib, forCellWithReuseIdentifier: "DummyPrimiumCell")
        }
    }

    extension PremimumPaidTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        
        
        func yourData(yourData: [PakResultVO]){
            filtered = yourData
        }
    //    // The data we passed from the TableView send them to the CollectionView Model
    //    func updateCellWith(row: [CollectionViewCellModel]) {
    //        self.rowWithColors = row
    //        self.collectionView.reloadData()
    //    }
        
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let cell = collectionView.cellForItem(at: indexPath) as? DummyPrimiumCell
            print("I'm tapping the \(indexPath.item)")
            print("I'm current Section tapping the \(indexPath.section)")
            print("I'm Plan Id  tapping the ",self.filtered[indexPath.item].plan_id)

            self.cellDelegate?.collectionView(collectionviewcell: cell, section: indexPath.section, index: indexPath.item, didTappedInTableViewCell: self)
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.filtered.count
        }
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        // Set the data for each cell (color and color name)
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DummyPrimiumCell", for: indexPath) as? DummyPrimiumCell {
                cell.lbl_disscount.text = "Save \(self.filtered[indexPath.item].discount ?? "0")"
//                cell.lbl_titlename.text = self.filtered[indexPath.item].name
//                cell.lbl_daycount.text = "\(self.filtered[indexPath.item].day ?? 0)"
                
                cell.lbl_daycount.text = self.filtered[indexPath.item].day
                cell.lbl_titlename.text = self.filtered[indexPath.item].name
                cell.lbl_mrp.text = self.filtered[indexPath.item].mrp
                cell.lbl_proece.text = self.filtered[indexPath.item].price
                
//                cell.imgview.image = UIImage(named: imageArray[indexPath.row])

               // cell.img_logo.sd_setImage(with:URL(string: self.filtered[indexPath.item].) , placeholderImage: #imageLiteral(resourceName: "bat"))
                
                return cell
            }
            return UICollectionViewCell()
        }
        
        // Add spaces at the beginning and the end of the collection view
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        }
    }
