//
//  DummyPrimiumCell.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 12/04/22.
//

import UIKit

class DummyPrimiumCell: UICollectionViewCell {
    
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var save_btn: UIButton!
    
    @IBOutlet weak var name: UIView!
    
    @IBOutlet weak var lbl_titlename: UILabel!
    
    @IBOutlet weak var lbl_disscount: UILabel!
    
    @IBOutlet weak var lbl_daycount: UILabel!
    @IBOutlet weak var lbl_mrp: UILabel!
    @IBOutlet weak var lbl_proece: UILabel!
    
    @IBOutlet weak var backview: CardView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backview.layer.cornerRadius = 6
        backview.layer.borderWidth = 1
        backview.layer.borderColor = UIColor.systemGray.cgColor
        
        save_btn.layer.cornerRadius = 6
        save_btn.layer.borderWidth = 1
        save_btn.layer.borderColor = UIColor.systemGray.cgColor
        
    }

}
