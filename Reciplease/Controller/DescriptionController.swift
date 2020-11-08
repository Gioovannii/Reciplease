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
    var recipeRepresentable: RecipeRepresentable?
    var ingredients = [String]()
    var isFavorite = false
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let recipe = recipeRepresentable else { return }
        guard let coreDataManager = coreDataManager else { return }
        let recipeTitle = recipe.label
        
        switch coreDataManager.isRecipeRegistered(for: recipeTitle) {
        case true:
            favoriteButton.image = UIImage(named: "fullHeart")
            
        case false:
            favoriteButton.image = UIImage(named: "emptyHeart")
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataManager = CoreDataManager(coreDataStack: appDelegate.coreDataStack)
        
        guard let ingredientLines = recipeRepresentable?.ingredientLines else { return }
        ingredients = ingredientLines
        
        guard let recipe = recipeRepresentable, let imageData = recipe.imageData else { return }
        recipeImageView.image = UIImage(data: imageData)
    }
    
    @IBAction func getDirectionsButtonTapped(_ sender: UIButton) {
        guard let shareAs = recipeRepresentable?.shareAs else { return }
        if let url = URL(string: shareAs) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        guard let recipe = recipeRepresentable else { return }
        let recipeTitle = recipe.label
        guard let coreDataManager = coreDataManager else { return }
        
        
        switch coreDataManager.isRecipeRegistered(for: recipeTitle) {
        case false:
            coreDataManager.createRecipe(title: recipe.label, health: recipe.healthLabels, time: recipe.totalTime, ingredients: recipe.ingredientLines, shareAs: recipe.shareAs, image: recipe.imageData)
            sender.image = UIImage(named: "fullHeart")
            
        case true:
            sender.image = UIImage(named: "emptyHeart")
            coreDataManager.deleteRecipe(for: recipe.label)
            if isFavorite { self.navigationController?.popViewController(animated: true)}
        }
    }
}

// MARK: - Data Source

extension DescriptionController: UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.instructions, for: indexPath)
        
        cell.textLabel?.text = ingredients[(indexPath.row)]
        cell.textLabel?.font = UIFont(name: Constant.papyrusFont, size: 17)
        cell.textLabel?.textColor = .white
        return cell
    }
    
    // MARK: - Header
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  recipeRepresentable?.label
    }
}

