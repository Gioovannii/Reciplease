//
//  FavoriteTableViewCOntrollerTableViewController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/9/23.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

final class FavoriteTableViewController: UITableViewController {
    
    private var coreDataManager: CoreDataManager?
    var recipeRepresentable: RecipeRepresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.reusableCell)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataManager = CoreDataManager(coreDataStack: appDelegate.coreDataStack)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.recipes.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCell, for: indexPath) as? RecipeTableViewCell else {
            print("Error while loading cell")
            return UITableViewCell()
        }
        
        cell.recipeEntity = coreDataManager?.recipes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = coreDataManager?.recipes[indexPath.row] else { return }
        recipeRepresentable = RecipeRepresentable(imageData: recipe.image, label: recipe.title ?? "", totalTime: recipe.time ?? "", healthLabels: recipe.healthLabel ?? "", ingredientLines: recipe.ingredients ?? [], shareAs: recipe.shareAs ?? "")
        performSegue(withIdentifier: K.toDescription, sender: nil)
        print("Perform from favorite")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.toDescription {
            let vcDestination = segue.destination as! DescriptionController
            vcDestination.recipeRepresentable = recipeRepresentable
            vcDestination.isFavorite = true
        }
    }
}

// MARK: - UITableView Delegate

extension FavoriteTableViewController {
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "You need to add some recipes"
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return coreDataManager?.recipes.isEmpty ?? true ? 420 : 0
    }
}

