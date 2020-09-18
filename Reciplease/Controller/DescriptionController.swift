//
//  DescriptionController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/9/3.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

final class DescriptionController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    // MARK: - Properties

    var recipe: Recipe?
    var ingredients = [String]()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeImageView.load(url: URL(string: recipe!.image)!)
        
        guard let ingr = recipe?.ingredientLines else { return }
        ingredients = ingr
    }
    
    @IBAction func getDirectionsButton(_ sender: UIButton) {
        guard let shareAs = recipe?.shareAs else { return }
        print(shareAs)
        
        // Ouvrir safari et allez a l'adresse
        
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

