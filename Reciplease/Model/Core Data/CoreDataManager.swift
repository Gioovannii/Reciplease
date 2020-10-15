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
    
    var recipes: [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        guard let recipes = try? managedObjectContext.fetch(request) else { return [] }
        return recipes
    }
    
    // MARK: - Initializer
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    // MARK: - Manage Task Entity
    
    func createRecipe(title: String, health: String, time: String, ingredients: [String]) {
        // TODO: - Image
        // TODO: - URL

        let recipe = RecipeEntity(context: managedObjectContext)
        recipe.title = title
        
        recipe.healthLabel = health
        recipe.time = time
        //recipe.ingredients = ingredients
        
        coreDataStack.saveContext()
        print(" coreDataManager: \(recipe.title as Any)")
    }
    
    func isRecipeRegistered(for name: String) -> Bool {
        
        // TODO: - faire requete qui recuper entite recette
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        // TODO: - appliquer filtre sur requete (predicate)
        request.predicate = NSPredicate(format: "title == %@", name)
        // TODO: - executer requete
        guard let recipes = try? managedObjectContext.fetch(request) else { return false }
        if recipes.isEmpty { return false }
        return true
        
    }
    
    func deleteRecipe(name: String) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        // TODO: - appliquer filtre sur requete (predicate)
        request.predicate = NSPredicate(format: "title == %@", name)
        // TODO: - executer requete
        guard let recipes = try? managedObjectContext.fetch(request) else { return }
        guard let recipe = recipes.first else { return }
        managedObjectContext.delete(recipe)
        coreDataStack.saveContext()
    }
}
