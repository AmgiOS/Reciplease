//
//  AddIngredientsViewController.swift
//  Reciplease
//
//  Created by Amg on 01/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit
import CoreData

class AddIngredientsViewController: UIViewController {

    //MARK: @IBOUTLET
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayIngredientList()
    }
    
    //MARK: @IBACTION
    @IBAction func addIngredientsButton(_ sender: Any) {
        guard let addIngredients = ingredientsTextField.text, !addIngredients.isEmpty,
            var listIngredients = ingredientsTextView.text else {
                alertTextFieldIsEmpty()
                return
        }
        
        listIngredients += "- " + addIngredients + "\n"
        ingredientsTextView.text = listIngredients
        ingredientsTextField.text = ""
        ingredientsTextField.endEditing(true)
        
        saveIngredients(named: addIngredients)
    }
    
    @IBAction func clearListButton(_ sender: UIButton) {
        ingredientsTextView.text.removeAll()
    }
    
    @IBAction func searchRecipe(_ sender: UIButton) {
        guard let listIngredients = ingredientsTextView.text, !listIngredients.isEmpty else {
            navigationController?.popViewController(animated: true)
            alertTextFieldIsEmpty()
            return
        }
    }
    
    //MARK: FUNCTIONS
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
                ingredientText += ingredient + "\n"
            }
        }
        ingredientsTextField.text = ingredientText
    }
}

extension AddIngredientsViewController: UITextFieldDelegate {
    //MARK: TEXTFIELD
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ingredientsTextField.endEditing(true)
        return true
    }
    
    //MARK: ALERT
    private func alertTextFieldIsEmpty() {
        let alert = UIAlertController(title: "Text Is Empty", message: "Enter ingredients", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
