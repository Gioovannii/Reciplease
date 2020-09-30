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
    
    var ingredients = [String]()
    
    var hit: Hit?
    
    var recipe: Recipe?
    var coreDataManager: CoreDataManager?
    
    
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
        guard let ingr = recipe?.ingredientLines else { return }
        ingredients = ingr
        
        //print("Hit data = \(hit?.bookmarked)")
    }
    
    @IBAction func getDirectionsButton(_ sender: UIButton) {
        guard let shareAs = recipe?.shareAs else { return }
        if let url = URL(string: shareAs) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func favoriteTapped(_ sender: UIBarButtonItem) {
        
        sender.image = UIImage(named: "fullHeart")
        guard coreDataManager?.title != nil else { return }
        coreDataManager?.createRecipe(title: recipe!.label, healthLabel: recipe!.healthLabels[0], image: recipe!.image, time: "\(recipe!.totalTime)", ingredients: recipe!.ingredientLines)

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
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  recipe?.label
    }
}

