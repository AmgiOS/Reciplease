//
//  RecipeRequestTableViewController.swift
//  Reciplease
//
//  Created by Amg on 01/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit

class RecipeRequestTableViewController: UITableViewController {
    //MARK: - Vars
    var recipeJson: RecipeJSON!
    var detailsRecipe: Details!
    var recipeService = RecipeService()
    
    //MARK: @IBOUTLET
    @IBOutlet var recipeRequestTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            guard let detailsController = segue.destination as? RecipeDetailsViewController else { return }
            detailsController.detailsRecipe = detailsRecipe
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeJson.matches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as? RecipeRequestTableViewCell else {
            return UITableViewCell()
        }
        let recipe = recipeJson?.matches[indexPath.row]
        cell.recipe = recipe
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RecipeRequestTableViewCell else { return }
        getDetailsRecipe(id: cell.recipe.id)
    }
    
    private func getDetailsRecipe(id: String) {
        recipeService.getDetailsRecipe(id: id) { (success, detail) in
            if success {
                self.detailsRecipe = detail
                self.performSegue(withIdentifier: "detailsSegue", sender: nil)
            }
        }
    }
}
