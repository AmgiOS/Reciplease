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
    @IBOutlet weak var ratesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var recipe: Description! {
        didSet {
            do {
                let url = URL(string: (recipe?.imageUrlsBySize.the90)!)
                let data = try Data(contentsOf: url!)
                self.recipeImageView.image = UIImage(data: data)
            }
            catch{
                print(error)
            }
            nameRecipeLabel.text = recipe?.recipeName ?? ""
            recipe?.ingredients.forEach({ (ingredient) in
                ingredientsLabel.text?.append(ingredient + ",")
            })
            ratesLabel.text = "\(String(describing: recipe.rating))/5" 
            timeLabel.text = "\(recipe.totalTimeInSeconds / 60) Min"
        }
    }
}
