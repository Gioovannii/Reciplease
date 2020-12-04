//
//  RecipesDataSource.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/11/26.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

protocol RecipesListViewControllerDelegate: class {
    func didSelectRecipe(with recipe: Hit)
}


final class RecipesDataSource: NSObject {
    
    // MARK: - Properties

    var recipes = [Hit]()
    //var recipe: Recipe?
    
    var didSelectRecipeAtIndex: ((Int) -> Void)?
    
    func update(with recipes: [Hit]) {
        self.recipes = recipes
    }
}

// MARK: - UITableView DataSource

extension RecipesDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.reusableCell, for: indexPath) as? RecipeTableViewCell else {
            print("Error while loading cell")
            return UITableViewCell()
    }
        cell.recipe = recipes[indexPath.row].recipe
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
}

