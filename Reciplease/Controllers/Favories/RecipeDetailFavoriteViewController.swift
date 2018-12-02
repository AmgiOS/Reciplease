//
//  RecipeDetailFavoriteViewController.swift
//  Reciplease
//
//  Created by Amg on 01/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit

class RecipeDetailFavoriteViewController: UIViewController {
    
    //MARK: - Vars
    var recipe: Recipe!
    
    //MARK: - @IBOutlet
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientTextView: UITextView!
    @IBOutlet weak var ratesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    //MARK: - @IBAction
    @IBAction func getUrlButton(_ sender: Any) {
        guard let url = URL(string: recipe.getUrl!) else { return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    //MARK: - Function
    private func setUp() {
        recipeImageView.image = UIImage(data: recipe.image!)
        nameLabel.text = recipe.name
        for element in recipe.details?.allObjects as! [DetailEntity] {
         ingredientTextView.text.append(element.list! + "\n")
        }
        timeLabel.text = recipe.time
        ratesLabel.text = recipe.rates
    }
}
