//
//  AddIngredientsViewModel.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/11/14.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import Foundation

final class AddIngredientsViewModel {
    
    private let ingredientService: IngredientService
    private let service: RequestService

    private var ingredients = [String]() {
        didSet {
            self.ingredientsList?(ingredients.map{ "- \($0)" })
        }
    }
    
    // MARK: - Initializer
    
    init(service: RequestService = RequestService(), ingredientService: IngredientService = IngredientService()) {
        self.service = service
        self.ingredientService = ingredientService
    }
    
    
    // MARK: - Outputs
    
    var recipes: (([Hit]) -> Void)?
    var isSearching: ((Bool) -> (Void))?
    var ingredientsList: (([String]) -> ())?
    
    // MARK: - Methods
    
    func addIngredient(name: String) {
        ingredientService.addIngredients(name: name)
        ingredients = ingredientService.ingredients
    }
    
    func deleteIngredient(index: Int) {
        ingredientService.deleteIngredient(at: index)
        ingredients = ingredientService.ingredients
    }
    
    func clearAllIngredients() {
        ingredientService.clearAllIngredients()
        ingredients = ingredientService.ingredients
    }
    
    func searchRecipes() {
        isSearching?(false)
        service.getData(ingredients: ingredients.joined()) { [unowned self] (result: Result<EdanamJSON, NetworkError>) in
            
            switch result {
            case .success(let data):
                isSearching?(true)
                self.recipes?(data.hits)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
