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
    var favorites: Favories!
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
        if !favoriesAll.isEmpty {
            deleteAllRecipe()
        }
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
        cell.ingredientsLabel.text = "\(favorie.ingredients?.allObjects as! [Ingredient])"
        print(favorie.ingredients?.allObjects as! [Ingredient])
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if favoriesAll.isEmpty {
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
            Favories.deleteAllData()
            self.favoriesAll = Favories.all
            self.favoriesTableView.reloadData()
        })))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
