//
//  StaticCell.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 26/04/22.
//

import UIKit

class StaticCell: UITableViewCell {
    
    @IBOutlet weak var gallery_btn: UIButton!
    
    @IBOutlet weak var text_btn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
