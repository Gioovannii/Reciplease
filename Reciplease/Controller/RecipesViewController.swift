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
        self.tableView.register(UINib(nibName: Constant.cellNibName, bundle: nil), forCellReuseIdentifier: Constant.reusableCell)
    }
    
    // MARK: - TableView

    override internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
    
    override internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.reusableCell, for: indexPath) as? RecipeTableViewCell else {
            print("Error while loading cell")
            return UITableViewCell()
        }
        
        cell.recipe = recipes?[indexPath.row].recipe
        return cell
    }
    
    override internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipe = recipes?[indexPath.row].recipe
        performSegue(withIdentifier: Constant.toDescription, sender: nil)
        print("Perform from network Call")
    }
    
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.toDescription {
            let vcDestination = segue.destination as! DescriptionController
            
            guard let recipe = recipe else { return }
            let timeConverted = Double().convert(minutes: Double(recipe.totalTime))
            
            let recipeRepresentable = RecipeRepresentable(label: recipe.label, imageData: recipe.image.data, healthLabels: recipe.healthLabels.first ?? "", ingredientLines: recipe.ingredientLines, totalTime: timeConverted, shareAs: recipe.shareAs)
            vcDestination.recipeRepresentable = recipeRepresentable
        }
    }
    
    override internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    // MARK: - Animation cells

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
