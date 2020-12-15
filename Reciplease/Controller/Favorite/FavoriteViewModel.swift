//
//  FavoriteViewModel.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/12/9.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import Foundation

final class FavoriteViewModel {
    
    // MARK: - Properties
    
    var recipe: RecipeEntity? {
        didSet {
                let recipeRepresentable = RecipeRepresentable(label: recipe!.title ?? "", imageData: recipe!.image, healthLabels: recipe!.healthLabel ?? "", ingredientLines: recipe!.ingredients ?? [], totalTime: recipe!.time ?? "", shareAs: recipe!.shareAs ?? "")
            recipeOutput?(recipeRepresentable)
        }
    }
    
    var coreDataManager: CoreDataManager
    
    // MARK: - Initializer

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - Outputs
    
    var recipeOutput: ((RecipeRepresentable) -> Void)?
    var recipesOutput: (([RecipeEntity]) -> Void)?
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        recipesOutput?(coreDataManager.recipes)
    }
    
    // MARK: - Method

    func didSelectRecipe(at index: Int) {
        self.recipe = coreDataManager.recipes[index]
       
    }
}
