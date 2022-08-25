//
//  CustomDesignCollectionViewCell.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 05/04/22.
//

import UIKit

class CustomDesignCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backview: UIView!
    
    @IBOutlet weak var imgview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backview.layer.borderColor = UIColor.white.cgColor
    }

}
