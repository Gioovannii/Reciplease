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
    
    // MARK: - Methods
    
    func didSelectRecipe(at index: Int) {
        //delegate?.didSelectRecipe(with: recipes[index])
        recipe = recipes[index].recipe
        recipeOutput?(recipe!)
    }
 
//    guard let recipe = viewModel?.recipe else { return }
//    let timeConverted = Double().convert(minutes: Double(recipe.totalTime))
//
//    let recipeRepresentable = RecipeRepresentable(label: recipe.label, imageData: recipe.image.data, healthLabels: recipe.healthLabels.first ?? "", ingredientLines: recipe.ingredientLines, totalTime: timeConverted, shareAs: recipe.shareAs)
//    vcDestination.recipeRepresentable = recipeRepresentable
}
