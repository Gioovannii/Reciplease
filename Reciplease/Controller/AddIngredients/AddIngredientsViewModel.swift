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
    private let service: RequestTestService
    private var ingredients = [String]() {
        didSet {
            self.ingredientsList?(ingredients.map{ "- \($0)" })
        }
    }
    
    // MARK: - Initializer
    init(service: RequestTestService = RequestService(), ingredientService: IngredientService = IngredientService()) {
        self.service = service
        self.ingredientService = ingredientService
    }
    
    // MARK: - Outputs
    var recipes: (([Hit]) -> Void)?
    var isSearching: ((Bool) -> (Void))?
    var ingredientsList: (([String]) -> ())?
    var messageAlert: ((String) -> (Void))?
    
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
                if data.q.isEmpty { messageAlert?("Please enter something") } else if data.hits.isEmpty {
                    messageAlert?("Please enter ingredient in english")}
                isSearching?(true)
                self.recipes?(data.hits)
                
            case .failure(let error):
                print(error.description)
                messageAlert?(error.description)

            }
        }
    }
}
