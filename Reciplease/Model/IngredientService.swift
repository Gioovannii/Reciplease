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
    
    var ingredientList: String {
        return ingredients.joined(separator: ",")
    }
    
    // MARK: - Methods
    
    func isIngredientAlreadyRegistered(element: String) -> Bool {
        guard ingredients.contains(element) else { return false }
        return true
    }
    
    func addIngredients(name: String) {
        guard !name.isEmpty else { return }
        let checkNameSymbols = name.components(separatedBy: .punctuationCharacters).filter { $0 != "" }
        guard isIngredientAlreadyRegistered(element: name) else { return ingredients.append(contentsOf: checkNameSymbols) }
    }
    
    func deleteIngredient(at index: Int) {
        ingredients.remove(at: index)
    }
    
    func clearAllIngredients() {
        ingredients.removeAll()
    }
}
