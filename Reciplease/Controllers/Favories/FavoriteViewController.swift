//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Amg on 01/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation
import UIKit

class FavoriteViewController: UIViewController {
    //MARK: - Vars
    var recipeAll = Recipe.all
    var ingredientAll = Ingredient.all
    
    //MARK - @IBOutlet
    @IBOutlet weak var favoriesTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.items?[1].badgeValue = nil
        recipeAll = Recipe.all
        ingredientAll = Ingredient.all
        favoriesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriesTableView.tableFooterView = UIView()
    }
    
    //MARK: - @IBAction
    @IBAction func removeAllList(_ sender: Any) {
        if !recipeAll.isEmpty {
            deleteAllRecipe()
        }
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoritesSegue" {
            guard let detailsFavories = segue.destination as? RecipeDetailFavoriteViewController else { return }
            detailsFavories.recipe = sender as? Recipe
        }
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeAll.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        let recipeIndex = recipeAll[indexPath.row]
        for element in recipeIndex.ingredients?.allObjects as! [Ingredient] {
            cell.ingredientsLabel.text?.append(element.name! + ",")
        }
        cell.recipe = recipeIndex
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            AppDelegate.viewContext.delete(recipeAll[indexPath.row])
            recipeAll.remove(at: indexPath.row)
            do {
                try AppDelegate.viewContext.save()
            } catch {
                print("error")
            }
            self.favoriesTableView.deleteRows(at: [indexPath], with: .automatic)
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FavoriteTableViewCell else { return }
        self.performSegue(withIdentifier: "favoritesSegue", sender: cell.recipe)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if recipeAll.isEmpty {
            let label = UILabel()
            label.text = "Get Recipe and Save it"
            label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            label.textAlignment = .center
            label.textColor = .white
            return label
        }
        return UIView()
    }
}

extension FavoriteViewController {
    //MARK: - Alert
    private func deleteAllRecipe() {
        let alert = UIAlertController(title: "Delete All Recipes", message: "Do you want delete all Recipes?", preferredStyle: .actionSheet)
        alert.addAction((UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            Ingredient.deleteAllIngredients()
            Recipe.deleteAllData()
            DetailEntity.deleteAllDetails()
            self.recipeAll = Recipe.all
            self.favoriesTableView.reloadData()
        })))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
