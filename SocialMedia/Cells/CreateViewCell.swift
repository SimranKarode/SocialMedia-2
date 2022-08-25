//
//  CreateViewCell.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 15/04/22.
//

import UIKit

class CreateViewCell: UICollectionViewCell {

    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var imgview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        backview.layer.borderWidth = 1
//        backview.layer.masksToBounds = false
//        backview.layer.borderColor = UIColor.systemOrange.cgColor
//        backview.clipsToBounds = true
    }
    
}
