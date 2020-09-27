//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/25.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {

    // MARK: - Properties

    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext

    var ingredients: [Ingredient] {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        guard let ingredients = try? managedObjectContext.fetch(request) else { return [] }
        return ingredients
    }
    
    var recipes: [Recipes] {
        let request: NSFetchRequest<Recipes> = Recipes.fetchRequest()
        guard let recipes = try? managedObjectContext.fetch(request) else { return [] }
        return recipes
    }

    // MARK: - Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }

    // MARK: - Manage Task Entity

    func createCell(title: String) {
//        let ingredient = Ingredient(context: managedObjectContext)
//        ingredient.name = name
//        coreDataStack.saveContext()
        
        let recipe = Recipes(context: managedObjectContext)
        recipe.title = title
        print(recipe.title as Any)
        coreDataStack.saveContext()
    }
}
