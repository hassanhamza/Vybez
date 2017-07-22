//
//  FavoriteViewCell.swift
//  Vybez
//
//  Created by Hassan on 6/23/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit

class FavoriteViewCell: UITableViewCell {

    
    
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var dateMilesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
