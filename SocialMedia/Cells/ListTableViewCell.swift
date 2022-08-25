//
//  ListTableViewCell.swift
//  GoldBecho
//
//  Created by ABDUL KADIR ANSARI on 24/09/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lbl_nameList: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
