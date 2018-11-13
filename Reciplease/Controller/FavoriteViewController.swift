//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Amg on 01/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    //MARK: - Vars
    var favoriesAll = Favories.all
    var ingredients: Ingredient!
    var ingredientAll = Ingredient.all
    
    //MARK - @IBOutlet
    @IBOutlet weak var favoriesTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.items?[1].badgeValue = nil
        favoriesAll = Favories.all
        ingredientAll = Ingredient.all
        favoriesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriesTableView.tableFooterView = UIView()
    }
    
    //MARK: - @IBAction
    @IBAction func removeAllList(_ sender: Any) {
        Ingredient.deleteAllIngredients()
        Favories.deleteAllData()
        favoriesAll = Favories.all
        favoriesTableView.reloadData()
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoritesSegue" {
            guard let detailsFavories = segue.destination as? RecipeDetailFavoriteViewController else { return }
            detailsFavories.favories = sender as? Favories
            detailsFavories.ingredients = ingredients
        }
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriesAll.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        let favorie = favoriesAll[indexPath.row]
        let ingredient = ingredientAll[indexPath.row]
        
        cell.favories = favorie
        cell.ingredientsLabel.text = ingredient.ingredients
        ingredients = ingredient
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            AppDelegate.viewContext.delete(favoriesAll[indexPath.row])
            favoriesAll.remove(at: indexPath.row)
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
        self.performSegue(withIdentifier: "favoritesSegue", sender: cell.favories)
    }
}
