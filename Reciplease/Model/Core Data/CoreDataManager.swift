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
        
        let recipe = RecipeEntity(context: managedObjectContext)
        recipe.title = title
        
        recipe.healthLabel = health
        recipe.time = time
        //recipe.ingredients = ingredients
        //favorite = recipe.isFavorite
        coreDataStack.saveContext()
        print(" coreDataManager: \(recipe.title as Any)")
    }
    
    func isRecipeRegistered(for name: String) -> Bool {
        
        // TODO: - faire requete qui recuper entite recette
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard let recipe = try? managedObjectContext.fetch(request) else { return false }
        print(recipe)
        // TODO: - appliquer filtre sur requete (predicate)
        request.predicate = NSPredicate(format: "name == %@", name)
        // TODO: - executer requete
        //request.execute()
        
        // TODO: - Analyser resultat tableau contient recette
        
        // TODO: - Si contient recette => favoris
        // TODO: - Contient => true
        // TODO: - sinon => false
        
        return false
    }
    
    func deleteRecipe() {
        
    }
}
