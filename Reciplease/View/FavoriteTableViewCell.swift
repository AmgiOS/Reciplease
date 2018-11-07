//
//  FavoriteTableViewCell.swift
//  Reciplease
//
//  Created by Amg on 01/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var ratesLabel: UILabel!
    @IBOutlet weak var timesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    //MARK: - Vars
    var favories: Favories! {
        didSet {
            imageRecipe.image = UIImage(data: favories.image!)
            nameLabel.text = favories.name ?? ""
            ratesLabel.text = "\(favories.rates!)"
            timesLabel.text = favories.time
        }
    }
}
