//
//  HomeCollectionViewCell.swift
//  SmartEVCard
//
//  Created by ABDUL KADIR ANSARI on 25/12/21.
//

import UIKit
import MarqueeLabel

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var category_image: UIImageView!
    
   // @IBOutlet weak var lbl_Categorytitle: UILabel!
    
    
    @IBOutlet weak var lbl_scroll: MarqueeLabel!
    @IBOutlet weak var lbl_showdate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        category_image.layer.cornerRadius = 1
        category_image.layer.borderWidth = 1
        category_image.layer.borderColor = UIColor.blue.cgColor
      //  self.startAnimation()
    }
    
//
    func startAnimation()
    {
        //Animating the label automatically change as per your requirement
        DispatchQueue.main.async(execute: {
            UIView.animate(withDuration: 10.0, delay: 1, options: ([.curveLinear, .repeat]), animations: {
                () -> Void in
                self.lbl_scroll.center = CGPoint(x: 0 - self.lbl_scroll.bounds.size.width / 2, y: self.lbl_scroll.center.y)
            }, completion:  nil)
        })
    }
    
}
