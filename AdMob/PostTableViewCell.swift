//
//  PostTableViewCell.swift
//  VenueList Final Project
//
//  Created by Bryan  Miller on 8/24/16.
//  Copyright © 2016 Iron Yard. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var postImageView: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    @IBOutlet weak var priceLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
