//
//  FavoriteTableViewCOntrollerTableViewController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/9/23.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

final class FavoriteTableViewController: UITableViewController {
    
    private var coreDataManager: CoreDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.reusableCell)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataManager = CoreDataManager(coreDataStack: appDelegate.coreDataStack)
        print(coreDataManager?.recipes ?? "   ")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.recipes.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCell, for: indexPath) as? RecipeTableViewCell else {
            print("Error while loading cell")
            return UITableViewCell()
        }
        
        cell.recipeEntity = coreDataManager?.recipes[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

// MARK: - UITableView Delegate

extension FavoriteTableViewController {}

