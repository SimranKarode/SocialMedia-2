//
//  PremiumCollectionViewCell.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 04/04/22.
//

import UIKit

class PremiumCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var backview: CardView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_digits: UILabel!
    @IBOutlet weak var lbl_months: UILabel!
    @IBOutlet weak var lbl_currentPrices: UILabel!
    @IBOutlet weak var lbl_disscount: UILabel!
    @IBOutlet weak var lbl_save: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
