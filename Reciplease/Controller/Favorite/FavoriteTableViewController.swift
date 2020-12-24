//
//  FavoriteTableViewCOntrollerTableViewController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/9/23.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

final class FavoriteTableViewController: UITableViewController {
    
    // MARK: - Propertie

    var viewModel: FavoriteViewModel?
    
    private let dataSource = FavoriteDataSource()
    private var coreDataManager: CoreDataManager?
    private var recipe: RecipeRepresentable?

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: Constant.cellNibName, bundle: nil), forCellReuseIdentifier: Constant.reusableCell)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataManager = CoreDataManager(coreDataStack: appDelegate.coreDataStack)
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        guard let coreDataManager = coreDataManager else { return }
        viewModel = FavoriteViewModel(coreDataManager: coreDataManager)
        bind()
    }

    func bind() {

        viewModel?.recipesOutput = { [weak self] recipes in
            DispatchQueue.main.async {
                self?.dataSource.update(with: recipes)
                self?.tableView.reloadData()
            }
        }

        viewModel?.recipeOutput = { [weak self] recipe in
            DispatchQueue.main.async {
                self?.recipe = recipe
                self?.performSegue(withIdentifier: Constant.toDescription, sender: nil)
            }
        }

        dataSource.didSelectRecipeAtIndex = viewModel?.didSelectRecipe
    }


//     MARK: - Prepare

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.toDescription {
            let vcDestination = segue.destination as! DescriptionController

            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            coreDataManager = CoreDataManager(coreDataStack: appDelegate.coreDataStack)

            guard let recipe = recipe else { return }
            vcDestination.viewModel = DescriptionViewModel(recipe: recipe, coreDataManager: coreDataManager!)
        }
    }
}
