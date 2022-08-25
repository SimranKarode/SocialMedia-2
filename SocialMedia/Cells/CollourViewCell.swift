//
//  CollourViewCell.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 07/04/22.
//

import UIKit

class CollourViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backview: CardView!
    
    @IBOutlet weak var imgview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backview.layer.cornerRadius = 6
        backview.layer.borderWidth = 1
        backview.layer.borderColor = UIColor.systemGray.cgColor

//        backview.layer.borderWidth = 1
//        backview.layer.masksToBounds = false
//        backview.layer.borderColor = UIColor.systemOrange.cgColor
//        backview.layer.cornerRadius = backview.frame.height/2
//        backview.layer.cornerRadius = backview.frame.width/2
//        backview.clipsToBounds = true
        
        
//        imgview.layer.borderWidth = 1
//        imgview.layer.masksToBounds = false
//        imgview.layer.borderColor = UIColor.systemOrange.cgColor
//        imgview.layer.cornerRadius = imgview.frame.height/2
//        backview.layer.cornerRadius = backview.frame.width/2
//        imgview.clipsToBounds = true
    }

}
