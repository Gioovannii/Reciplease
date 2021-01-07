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
    
    var recipes = [Hit]()
    
    var recipe: Recipe? {
        didSet {
            if let recipe = recipe {
                let timeConverted = Double().convert(minutes: Double(recipe.totalTime))
                
                let recipeRepresentable = RecipeRepresentable(label: recipe.label, imageData: recipe.image.data, healthLabels: recipe.healthLabels.first ?? "", ingredientLines: recipe.ingredientLines, totalTime: "\(timeConverted)", shareAs: recipe.shareAs)
                
                recipeOutput?(recipeRepresentable)
            }
        }
    }
    
    // MARK: - Initializer

    init(recipes: [Hit]) {
        self.recipes = recipes
    }
    
    // MARK: - Outputs
    
    var recipesOutput: (([Hit]) -> Void)?
    var recipeOutput: ((RecipeRepresentable) -> Void)?
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        recipesOutput?(recipes)
    }
    
    // MARK: - Methods
    
    func didSelectRecipe(at index: Int) {
        recipe = recipes[index].recipe
    }
}
