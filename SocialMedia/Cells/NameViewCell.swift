//
//  NameViewCell.swift
//  SocialMedia
//
//  Created by Abdul on 14/05/22.
//

import UIKit

class NameViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backview: CardView!
    
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var lbl_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        backview.layer.cornerRadius = 6
        backview.layer.borderWidth = 1
        backview.layer.borderColor = UIColor.systemGray.cgColor
        // Initialization code
    }
    
}
