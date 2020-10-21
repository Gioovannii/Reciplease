//
//  DescriptionController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/9/3.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit
import SDWebImage

final class DescriptionController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    var coreDataManager: CoreDataManager?
    var recipe: Recipe?
    var ingredients = [String]()
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataManager = CoreDataManager(coreDataStack: appDelegate.coreDataStack)
        
        guard let url = URL(string: recipe!.image) else { return }
        recipeImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "cooking"),
                                    options: [], completed: nil)
        guard let ingredientLines = recipe?.ingredientLines else { return }
        ingredients = ingredientLines
    }
    
    @IBAction func getDirectionsButtonTapped(_ sender: UIButton) {
        guard let shareAs = recipe?.shareAs else { return }
        if let url = URL(string: shareAs) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        guard let recipe = recipe else { return }
        let recipeTitle = recipe.label
        guard let coreDataManager = coreDataManager else { return }
        guard let health = recipe.healthLabels.first else { return }
        
        if !coreDataManager.isRecipeRegistered(for: recipeTitle) {
            // TODO: - Image
            // TODO: - URL
            
            coreDataManager.createRecipe(title: recipe.label, health: health, time: "\(recipe.totalTime)", ingredients: recipe.ingredientLines, sourceUrl: recipe.url)
            print(coreDataManager.recipes)
            sender.image = UIImage(named: "fullHeart")
        } else {
            sender.image = UIImage(named: "emptyHeart")
            coreDataManager.deleteRecipe(for: recipe.label)
        }
    }
}

// MARK: - Data Source

extension DescriptionController: UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.instructions, for: indexPath)
        
        cell.textLabel?.text = ingredients[(indexPath.row)]
        cell.textLabel?.font = UIFont(name: K.papyrusFont, size: 17)
        cell.textLabel?.textColor = .white
        return cell
    }
    
    // MARK: - Header

    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  recipe?.label
    }
}

