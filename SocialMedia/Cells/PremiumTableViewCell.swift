//
//  PremiumTableViewCell.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 04/04/22.
//

import UIKit

class PremiumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backview: CardView!
    
    @IBOutlet weak var lbl_title: UILabel!
    
    @IBOutlet weak var lbl_Digits: UILabel!
    
    @IBOutlet weak var lbl_months: UILabel!
    
    @IBOutlet weak var lbl_actualprices: UILabel!
    
    @IBOutlet weak var lbl_disscount: UILabel!
    
    @IBOutlet weak var lbl_savings: UILabel!
    
    @IBOutlet weak var lbl_hide: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
