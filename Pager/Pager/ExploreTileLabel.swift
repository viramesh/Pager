//
//  ExploreTileLabel.swift
//  Pager
//
//  Created by Vignesh Ramesh on 7/30/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class ExploreTileLabel: UILabel {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func drawTextInRect(rect: CGRect) {
        var insets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
}
