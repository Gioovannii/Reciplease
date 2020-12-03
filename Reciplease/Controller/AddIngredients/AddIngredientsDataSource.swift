//
//  AddIngredientsDataSource.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/11/17.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

final class AddIngredientDataSource: NSObject {
    
    // MARK: - Properties
    
    private var ingredients = [String]()
    var deleteIngredientWithIndex: ((Int) -> Void)?
    
    // MARK: - Methods
    
    func update(with ingredients: [String]) {
        self.ingredients = ingredients
    }
}

// MARK: - UITableViewDataSource

extension AddIngredientDataSource: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteIngredientWithIndex?(indexPath.row)            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredientCell = tableView.dequeueReusableCell(withIdentifier: Constant.ingredient, for: indexPath)
        
        ingredientCell.textLabel?.text = ingredients[indexPath.row]
        ingredientCell.textLabel?.textColor = UIColor.white
        ingredientCell.textLabel?.font = UIFont(name: Constant.papyrusFont, size: 20)
        return ingredientCell
    }
}
