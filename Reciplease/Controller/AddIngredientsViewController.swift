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
    var recipeService = RecipeService()
    var ingredientList = [String]()
    var recipeJSON: RecipeJSON?
    
    //MARK: - @IBOUTLET
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.tableFooterView = UIView()
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
        ingredientList.removeAll()
        ingredientsTableView.reloadData()
    }
    
    @IBAction func searchRecipe(_ sender: UIButton) {
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

extension AddIngredientsViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredient", for: indexPath)
        let ingredient = ingredientList[indexPath.row]
        
        cell.textLabel?.text = "- " + ingredient.firstUppercased
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredientList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            ingredientsTableView.reloadData()
        }
    }
}

extension AddIngredientsViewController {
    //MARK: - FUNCTIONS
    private func separatedComma(text: String) {
        let textComma = text.split(separator: " ")
        for element in textComma {
            ingredientList.append(String(element))
        }
        ingredientsTableView.reloadData()
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
