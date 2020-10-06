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
    
    var title = ""
    var favorite = false
    
    var recipes: [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard let recipes = try? managedObjectContext.fetch(request) else { return [] }
        return recipes
    }

    // MARK: - Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }

    // MARK: - Manage Task Entity

    func createRecipe(title: String, healthLabel: String, time: String, ingredients: [String]) {
        // TODO: - Image

        let recipe = RecipeEntity(context: managedObjectContext)
        recipe.title = title
        self.title = recipe.title!
        recipe.healthLabel = healthLabel
        recipe.time = time
//        recipe.ingredients = ingredients
        //favorite = recipe.isFavorite
        coreDataStack.saveContext()
        print(" coreDataManager: \(recipe.title as Any)")
    }
    
    func checkRecipeName(title name: String) {
        if name == self.title {
            
        }
    }
}
