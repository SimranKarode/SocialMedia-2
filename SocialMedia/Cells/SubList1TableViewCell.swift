//
//  SubList1TableViewCell.swift
//  SocialMedia
//
//  Created by Abdul on 25/06/22.
//

import UIKit

class SubList1TableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_title: UILabel!
    
    @IBOutlet weak var lbl_startdate: UILabel!
    
    @IBOutlet weak var lbl_expiredate: UILabel!
    
    @IBOutlet weak var btn_invite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        btn_invite.layer.cornerRadius = 10
        btn_invite.layer.borderWidth = 1
        btn_invite.layer.borderColor = UIColor.white.cgColor

        // Configure the view for the selected state
    }
    
}
