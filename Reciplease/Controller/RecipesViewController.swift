//
//  RecipeController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/27.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

final class RecipesViewcontroller: UITableViewController {
    
    var recipes: [Hit]?
    var index = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.reusableCell)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCell, for: indexPath) as? RecipeTableViewCell else {
            print("Error while loading cell)")
            return UITableViewCell()
        }
        
        cell.recipe = recipes?[indexPath.row].recipe
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        performSegue(withIdentifier: "ToDescription", sender: nil)
        print("Indexxxxxxxxxxx: \(index)")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDescription" {
            let vcDestination = segue.destination as! DescriptionController
            vcDestination.ingredients = recipes?[index].recipe.ingredientLines as! [String]
            vcDestination.recipe?.image = recipes?[index].recipe.image
           // vcDestination.image?.load(url: URL(string: (recipes?[index].recipe.image)!)!)
            vcDestination.titleRecipe = recipes?[index].recipe.label
            print("Title  == \(String(describing: recipes?[index].recipe.label))")
            print(vcDestination)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    //    func checkTime(recipe: Recipe, index) {
    //        if recipe
    //    }
}


