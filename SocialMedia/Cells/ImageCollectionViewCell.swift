//
//  ImageCollectionViewCell.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 06/04/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backview: CardView!
    
    @IBOutlet weak var imgview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
//        backview.layer.cornerRadius = 6
//        backview.layer.borderWidth = 1
//        backview.layer.borderColor = UIColor.systemGray.cgColor
    }

    
}
