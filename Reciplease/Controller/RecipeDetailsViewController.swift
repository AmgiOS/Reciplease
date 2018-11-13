//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Amg on 01/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit
import UserNotifications

class RecipeDetailsViewController: UIViewController {
    //MARK: - Vars
    var detailsRecipe: Details!
    var favorie = Favories.all
    
    //MARK: - @IBOUTLET
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var listIngredientsTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayDetails()
    }
    
    //MARK: - @IBAction
    @IBAction func openUrlButton(_ sender: Any) {
        guard let url = URL(string: detailsRecipe.source.sourceRecipeURL) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func saveRecipe(_ sender: Any) {
        saveRecipe()
        saveButton.tintColor? = UIColor.red
        tabBarController?.tabBar.items?[1].badgeValue = "New"
    }
}

extension RecipeDetailsViewController {
    //MARK: - Functions
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
    
    private func saveRecipe() {
        let favories = Favories(context: AppDelegate.viewContext)
        guard let url = URL(string: (detailsRecipe.images[0].hostedLargeURL)) else { return }
        let data = try? Data(contentsOf: url)
        favories.image = data
        favories.name = detailsRecipe.name
        favories.getUrl = detailsRecipe.source.sourceRecipeURL
        favories.rates = "\(detailsRecipe.rating)⭐️"
        favories.time = detailsRecipe.totalTime + "🕑"
        let ingredient = Ingredient(context: AppDelegate.viewContext)
        detailsRecipe.ingredientLines.forEach { (element) in
            ingredient.ingredients = element + "..."
        }
        ingredient.details = listIngredientsTextView.text
        ingredient.recipe = favories
        do {
            try AppDelegate.viewContext.save()
            favorie = Favories.all
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }
}

extension RecipeDetailsViewController {
    //MARK - Alert
    private func alertSaveRecipe() {
        let alert = UIAlertController(title: "Save", message: "You have save this recipe in your library", preferredStyle: .alert)
        self.present(alert, animated: true) {
            
        }
    }
}
