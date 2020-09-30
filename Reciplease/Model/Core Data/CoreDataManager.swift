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

    func createRecipe(title: String, healthLabel: String, image: String, time: String, ingredients: [String]) {
        
        let recipe = RecipeEntity(context: managedObjectContext)
        recipe.title = title
        recipe.healthLabel = healthLabel
        //recipe.image = image
        recipe.time = time
        recipe.ingredients = ingredients 
        coreDataStack.saveContext()
        print(" coreDataManager: \(recipe.title as Any)")
    }
}
