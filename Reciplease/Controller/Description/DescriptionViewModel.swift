//
//  DescriptionViewModel.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/12/6.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//


import Foundation

final class DescriptionViewModel {
    
    // MARK: - Properties
    var recipe: RecipeRepresentable {
        didSet {
            recipeOutput?(recipe)
        }
    }
    
    var coreDataManager: CoreDataManager
    
    // MARK: - Initializer
    init(recipe: RecipeRepresentable, coreDataManager: CoreDataManager) {
        self.recipe = recipe
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - Outputs
    var recipeOutput: ((RecipeRepresentable) -> Void)?
    var isFavoriteOutput: ((Bool) -> Void)?
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        recipeOutput?(recipe)
        favoriteLoad()
    }
    
    // MARK: - Methods
    
    func favoriteLoad() {
        switch coreDataManager.isRecipeRegistered(for: recipe.label) {
        case false:
            isFavoriteOutput?(false)
        case true:
            isFavoriteOutput?(true)
            
        }
    }
    
    func tapFavorite() {
        switch coreDataManager.isRecipeRegistered(for: recipe.label) {
        case false:
            coreDataManager.createRecipe(title: recipe.label, health: recipe.healthLabels, time: recipe.totalTime, ingredients: recipe.ingredientLines, shareAs: recipe.shareAs, image: recipe.imageData)
            isFavoriteOutput?(true)
            
        case true:
            coreDataManager.deleteRecipe(for: recipe.label)
            isFavoriteOutput?(false)
            print(coreDataManager.recipes.last as Any)
        }
    }
}
