//
//  BannerTableViewCell.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 09/03/22.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionview_Main: BJAutoScrollingCollectionView!
    
    @IBOutlet weak var backview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
