//
//  AutocompleteTableViewCell.swift
//  Pager
//
//  Created by Vignesh Ramesh on 8/3/15.
//  Copyright (c) 2015 SOMA. All rights reserved.
//

import UIKit

class AutocompleteTableViewCell: UITableViewCell {

    @IBOutlet weak var autocompleteSuggestionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
