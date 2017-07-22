//
//  DetailDiscoverViewCell.swift
//  Vybez
//
//  Created by Hassan on 6/21/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit

class DetailDiscoverViewCell: UITableViewCell {

    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
