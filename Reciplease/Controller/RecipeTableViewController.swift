//
//  RecipeController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/27.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

class RecipeTableViewcontroller: UITableViewController {
    
    var coreDataManager: CoreDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    // MARK: - UITableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.recipeIdentifier, for: indexPath) as? RecipeCell else {
            print("Error ehile loading cell)")
            return UITableViewCell()
        }
        
        cell.configure(withImage: "pizza-margherita", title: "Pizza", ingredients: "Mozzarella, tomatoes")
        return cell
        
    }
}


