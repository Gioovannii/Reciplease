//
//  RecipeController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/27.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

final class RecipesViewcontroller: UITableViewController {
    
    // MARK: - Properties

    var recipes: [Hit]?
    var recipe: Recipe?
    
    // MARK: - Life Cycle

    override internal func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.reusableCell)
    }
    
    // MARK: - TableView

    override internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
    
    override internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCell, for: indexPath) as? RecipeTableViewCell else {
            print("Error while loading cell")
            return UITableViewCell()
        }
        
        cell.recipe = recipes?[indexPath.row].recipe
        
        return cell
    }
    
    override internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.index = indexPath.row
        recipe = recipes?[indexPath.row].recipe

        performSegue(withIdentifier: K.toDescription, sender: nil)
    }
    
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.toDescription {
            let vcDestination = segue.destination as! DescriptionController
//            vcDestination.recipe = recipe
            guard let recipe = recipe else { return }
            let recipeRepresentable = RecipeRepresentable(imageData: recipe.image.data, source: recipe.source, ingredients: recipe.ingredientLines, label: recipe.label, totalTime: "", healthLabels: recipe.healthLabels, ingredientLines: recipe.ingredientLines)
            vcDestination.recipeRepresentable = recipeRepresentable
        }
    }
    
    override internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    // MARK: - Animation cellules

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let translationMouvement = CATransform3DTranslate(CATransform3DIdentity, 0, 100, 0)
        cell.layer.transform = translationMouvement
        cell.alpha = 0
        UIView.animate(withDuration: 0.20) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}
