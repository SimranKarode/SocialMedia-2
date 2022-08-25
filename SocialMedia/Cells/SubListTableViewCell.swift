//
//  SubListTableViewCell.swift
//  SocialMedia
//
//  Created by Abdul on 25/06/22.
//

import UIKit

class SubListTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_invoice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        lbl_invoice.layer.cornerRadius = 10
        lbl_invoice.layer.borderWidth = 1
        lbl_invoice.layer.borderColor = UIColor.white.cgColor
    }
    
}
