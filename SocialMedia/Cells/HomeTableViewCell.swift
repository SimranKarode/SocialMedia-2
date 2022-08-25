//
//  HomeTableViewCell.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 09/03/22.
//

import UIKit

protocol HomeCollectionViewCellDelegate: AnyObject {
    func homeCollectionView(collectionviewcell: HomeCollectionViewCell?, section: Int,index: String, title: String, didTappedInTableViewCell: HomeTableViewCell, sectionTitle: String)
    // other delegate methods that you can define to perform action in viewcontroller
}

class HomeTableViewCell: UITableViewCell {
    
    weak var cellDelegate: HomeCollectionViewCellDelegate?
//    var rowWithColors: [CollectionViewCellModel]?

    
    @IBOutlet weak var backview: UIView!
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var More_Btn: UIButton!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var filteredVO:[VideosJsonVO] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        self.lbl_Name.textColor = UIColor.white
        
        // TODO: need to setup collection view flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 150, height: 200)
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        self.imageCollectionView.collectionViewLayout = flowLayout
        self.imageCollectionView.showsHorizontalScrollIndicator = false
        
        // Comment if you set Datasource and delegate in .xib
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.delegate = self
        
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        self.imageCollectionView.register(cellNib, forCellWithReuseIdentifier: "HomeCollectionViewCell")
//        self.startAnimation()
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        More_Btn.layer.cornerRadius = 10
        More_Btn.layer.borderWidth = 1.0
        More_Btn.layer.borderColor = UIColor.clear.cgColor
    }
    
}
extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func yourData(yourData: [VideosJsonVO]){
 //        filteredVO = yourData
//    }
//    // The data we passed from the TableView send them to the CollectionView Model
//    func updateCellWith(row: [CollectionViewCellModel]) {
//        self.rowWithColors = row
//        self.collectionView.reloadData()
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell
        print("I'm tapping the \(indexPath.item)")
        print("I'm current Section tapping the \(indexPath.section)")
        print("I'm Plan Id  tapping the ",self.filteredVO[indexPath.item].title)

        
        self.cellDelegate?.homeCollectionView(collectionviewcell: cell, section: indexPath.section, index: self.filteredVO[indexPath.item].videos_id ?? "",title: self.filteredVO[indexPath.item].title ?? "", didTappedInTableViewCell: self, sectionTitle: lbl_Name.text!)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredVO.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Set the data for each cell (color and color name)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell {
            if self.filteredVO.count > 0 {
                cell.lbl_scroll.text = self.filteredVO[indexPath.item].title
                cell.lbl_showdate.text = self.filteredVO[indexPath.item].release
            }else{
                cell.lbl_scroll.text = "Test Data Test Data"
            }
            
//            if filteredVO.count == 0 {
//
//            }else if filteredVO.count == 1 {
//
//            }else{
//
//            }
            
            
            
//            cell.lbl_title.text = self.filtered[indexPath.item].videos_id

            cell.category_image.sd_setImage(with:URL(string: self.filteredVO[indexPath.item].poster_url!) , placeholderImage: #imageLiteral(resourceName: "latestst123"))
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    // Add spaces at the beginning and the end of the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}
