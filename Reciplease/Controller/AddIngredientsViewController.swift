//
//  AddIngredientsViewController.swift
//  Reciplease
//
//  Created by Amg on 01/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit

class AddIngredientsViewController: UIViewController {
    
    //MARK: - Vars
    var ingredient = Ingredients.all
    var recipeService = RecipeService()
    var ingredientList = [String]()
    var recipeJSON: RecipeJSON?
    
    //MARK: - @IBOUTLET
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayIngredientList()
    }
    
    //MARK: - @IBACTION
    @IBAction func addIngredientsButton(_ sender: Any) {
        guard let addIngredients = ingredientsTextField.text, !addIngredients.isEmpty else {
            alertTextFieldIsEmpty()
            return
        }
        separatedComma(text: addIngredients)
        ingredientsTextField.text = ""
        ingredientsTextField.endEditing(true)
    }
    
    @IBAction func clearListButton(_ sender: UIButton) {
        Ingredients.deleteAll()
        ingredient = Ingredients.all
        ingredientsTextView.text = ""
    }
    
    @IBAction func searchRecipe(_ sender: UIButton) {
        guard let listIngredients = ingredientsTextView.text, !listIngredients.isEmpty else {
            alertTextFieldIsEmpty()
            return
        }
        self.loadingRequestIndicator(show: true)
        recipeService.getRecipe(ingredients: ingredientList) { (success, recipe) in
            if success {
                self.recipeJSON = recipe
                self.loadingRequestIndicator(show: false)
                self.performSegue(withIdentifier: "segueRequest", sender: nil)
            }
        }
    }
}

extension AddIngredientsViewController {
    //MARK: - FUNCTIONS
    private func saveIngredients(named ingredients: String) {
        let ingredient = Ingredients(context: AppDelegate.viewContext)
        ingredient.ingredient = ingredients
        do {
            try AppDelegate.viewContext.save()
        } catch {
            print("error save ingredients")
        }
    }
    
    private func displayIngredientList() {
        var ingredientText = ""
        for ingredients in Ingredients.all {
            if let ingredient = ingredients.ingredient {
                ingredientText += ingredient
            }
        }
        ingredientsTextView.text = ingredientText
    }
    
    private func separatedComma(text: String) {
        var textSeparated = ""
        let textComma = text.split(separator: " ")
        for element in textComma {
            ingredientList.append(String(element))
            textSeparated += String(element) + "," + "\n"
        }
        ingredientsTextView.text += textSeparated
        saveIngredients(named: textSeparated)
    }
    
    private func loadingRequestIndicator(show: Bool) {
        if show == true {
            self.searchButton.isHidden = true
            self.activityIndicator.startAnimating()
        } else {
            self.searchButton.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueRequest" {
            guard let recipeController = segue.destination as? RecipeRequestTableViewController else { return }
                recipeController.recipeJson = recipeJSON
        }
    }
}

extension AddIngredientsViewController: UITextFieldDelegate {
    //MARK: - TEXTFIELD
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ingredientsTextField.endEditing(true)
        return true
    }
    
    //MARK: - ALERT
    private func alertTextFieldIsEmpty() {
        let alert = UIAlertController(title: "Text Is Empty", message: "Enter ingredients", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
