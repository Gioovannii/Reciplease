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
    private var index = 0

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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        performSegue(withIdentifier: K.toDescription, sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.toDescription {
            let vcDestination = segue.destination as! DescriptionController
            vcDestination.recipeEntity = coreDataManager?.recipes[index]   //recipes?[index].recipe
        }
    }
}

// MARK: - UITableView Delegate

extension FavoriteTableViewController {
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "You need to add some recipes"
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return coreDataManager?.recipes.isEmpty ?? true ? 420 : 0
    }
}

