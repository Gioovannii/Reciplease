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

        let recipe = RecipeEntity(context: managedObjectContext)
        recipe.title = title
        
        recipe.healthLabel = health
        recipe.time = time
        recipe.ingredients = ingredients
        //favorite = recipe.isFavorite
        coreDataStack.saveContext()
        print(" coreDataManager: \(recipe.title as Any)")
    }
    
    func isRecipeRegistered(for name: String) -> Bool {
        
        // TODO: - faire requete qui recuper entite recette
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard let recipe = try? managedObjectContext.fetch(request) else { return false }
        
        // TODO: - appliquer filtre sur requete (predicate)
        let predicate = NSPredicate(format: "SELF CONTAINS %@", "name")
        recipe.filter { element  in
            return
        }
        //recipe.filter(NSPredicate(format: "SELF CONTAINS %@", "name"))
        
        
        // TODO: - executer requete
        // TODO: -analyser resultat tableau contient recette
        // TODO: - si contient recette => favoris
        // TODO: - contient true
        // TODO: - false
        
        return true
    }
    
    func deleteRecipe() {
        
    }
}
