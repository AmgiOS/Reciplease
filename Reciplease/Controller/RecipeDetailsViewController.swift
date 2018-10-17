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
    var detailsRecipe: RecipeJSON?
    //MARK: - @IBOUTLET
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var listIngredientsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayDetails()
    }

    private func displayDetails() {
        guard var ingredientsList = listIngredientsTextView.text, !ingredientsList.isEmpty else {
            return
        }
        ingredientsList = "ingredients"
    }
}
