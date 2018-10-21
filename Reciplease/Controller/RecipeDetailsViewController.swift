//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Amg on 01/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    //MARK: - Vars
    var detailsRecipe: Details!
    //MARK: - @IBOUTLET
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var listIngredientsTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayDetails()
    }
    
    @IBAction func openUrlButton(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: detailsRecipe.source.sourceRecipeURL)!)
    }
    

    private func displayDetails() {
        nameLabel.text = detailsRecipe!.name
        do {
            let url = URL(string: (detailsRecipe!.images[0].hostedLargeURL))
            let data = try Data(contentsOf: url!)
            self.recipeImageView.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
        for ingredients in detailsRecipe.ingredientLines {
            listIngredientsTextView.text.append("\n" + ingredients)
        }
        ratingLabel.text = "\(detailsRecipe.rating)/5⭐️"
        timeLabel.text = detailsRecipe.totalTime + "🕑"
    }
}
