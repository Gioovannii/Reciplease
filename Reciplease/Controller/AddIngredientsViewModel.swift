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
    
    var output: Recipe?
    var ingredientsList: (([String]) -> ())?
    
    
    // MARK: - Inputs
    
    func viewDidLoad() {
        
    }

    func addIngredient(name: String) {
        ingredientService.addIngredients(name: name)
        ingredients = ingredientService.ingredients
    }
    
    func deleteIngredient() {

    }
}
