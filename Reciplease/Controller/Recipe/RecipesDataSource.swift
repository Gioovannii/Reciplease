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
}
