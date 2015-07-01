//
//  ExploreTableViewCell.swift
//  Pager
//
//  Created by Vignesh Ramesh on 6/30/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {

    @IBOutlet weak var exploreImageContainer: UIView!
    @IBOutlet weak var exploreImageOverlayView: UIView!
    
    @IBOutlet weak var exploreImageOverlayGradient: UIImageView!
    @IBOutlet weak var exploreImageOverlayLabel: UILabel!
    var exploreImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
