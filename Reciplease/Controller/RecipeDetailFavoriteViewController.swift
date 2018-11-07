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
    var ingredients: Ingredient?
    //MARK: - @IBOutlet
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientTextView: UITextView!
    @IBOutlet weak var ratesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        print(ingredients?.ingredients)
    }
    
    @IBAction func getUrlButton(_ sender: Any) {
        guard let url = URL(string: favories.getUrl!) else { return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func setUp() {
        recipeImageView.image = UIImage(data: favories.image!)
        nameLabel.text = favories.name
        timeLabel.text = favories.time
        ratesLabel.text = favories.rates
    }
}
