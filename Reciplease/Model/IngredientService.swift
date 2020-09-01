//
//  IngredientService.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/30.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import Foundation

final class IngredientService {
    
    // MARK: - Property
    
    var ingredients = [String]()
    
    // MARK: - Methods
    
    func addIngredients(name: String) {
        ingredients.append(name)
    }
    
    func deleteIngredient(at index: Int) {
        ingredients.remove(at: index)
    }
    
    func clearAllIngredients() {
        ingredients.removeAll()
    }
}
