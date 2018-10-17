//
//  RecipeRequestTableViewCell.swift
//  Reciplease
//
//  Created by Amg on 01/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit

class RecipeRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var nameRecipeLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    var recipe: Description? {
        didSet {
            nameRecipeLabel.text = recipe?.recipeName ?? ""
            recipe?.ingredients.forEach({ (ingredient) in
                ingredientsLabel.text = ingredient + " ..."
            })
        }
    }
}
