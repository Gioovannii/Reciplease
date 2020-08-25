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

    // MARK: - Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }

    // MARK: - Manage Task Entity

    func createIngredient(name: String) {
        let ingredient = Ingredient(context: managedObjectContext)
        ingredient.name = name
        coreDataStack.saveContext()
    }

    func deleteAllIngredients() {
        ingredients.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
}
