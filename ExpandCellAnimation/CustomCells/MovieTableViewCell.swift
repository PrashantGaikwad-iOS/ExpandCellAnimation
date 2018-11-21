//
//  MovieTableViewCell.swift
//  ExpandCellAnimation
//
//  Created by Prashant G on 11/21/18.
//  Copyright © 2018 MyOrg. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieDescription: UILabel!
    @IBOutlet var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.layer.cornerRadius = 40
        movieImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
