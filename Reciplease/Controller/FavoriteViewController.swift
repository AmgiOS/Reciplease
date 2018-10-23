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
    var favories = Favories.all
    var favorie: Favories!
    //MARK - @IBOutlet
    @IBOutlet weak var favoriesTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favories = Favories.all
        favoriesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriesTableView.tableFooterView = UIView()
    }
    
    @IBAction func removeAllList(_ sender: Any) {
        Favories.deleteAllData()
        favories = Favories.all
        favoriesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoritesSegue" {
            guard let detailsFavories = segue.destination as? RecipeDetailFavoriteViewController else { return }
            detailsFavories.favories = sender as? Favories
        }
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        let favorie = favories[indexPath.row]
        
        cell.favories = favorie
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            AppDelegate.viewContext.delete(favories[indexPath.row])
            favories.remove(at: indexPath.row)
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
