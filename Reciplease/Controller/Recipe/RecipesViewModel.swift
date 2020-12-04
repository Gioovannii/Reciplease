//
//  RecipesViewModel.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/11/26.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import Foundation

final class RecipesViewModel {
    
    // MARK: - Properties
   // private weak var delegate: RecipesListViewControllerDelegate?
    
    var recipe: Recipe?
    var recipes = [Hit]() {
        didSet {
            recipesOutput?(recipes)
        }
    }
    // MARK: - Initializer

    init(recipes: [Hit]) {
        self.recipes = recipes
    }
    
    // MARK: - Outputs
    var recipesOutput: (([Hit]) -> Void)?
    var recipeOutput: ((Recipe) -> Void)?
    
    // MARK: - Inputs
    func viewDidLoad() {
        recipesOutput?(recipes)
    }
    
   
}
