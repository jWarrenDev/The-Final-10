//
//  MoviesTableViewCell.swift
//  The 10 - Jerrick Warren
//
//  Created by Jerrick Warren on 2/15/19.
//  Copyright © 2019 Jerrick Warren. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
