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
    var favories: Favories!
    var ingredients: Ingredient!
    var ingredientAll = Ingredient.all
    
    //MARK: - @IBOutlet
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientTextView: UITextView!
    @IBOutlet weak var ratesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ingredientAll = Ingredient.all
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    //MARK: - @IBAction
    @IBAction func getUrlButton(_ sender: Any) {
        guard let url = URL(string: favories.getUrl!) else { return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    //MARK: - Function
    private func setUp() {
        recipeImageView.image = UIImage(data: favories.image!)
        nameLabel.text = favories.name
        ingredientTextView.text = ingredients.name
        timeLabel.text = favories.time
        ratesLabel.text = favories.rates
    }
}
