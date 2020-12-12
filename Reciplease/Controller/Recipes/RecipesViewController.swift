//
//  RecipeController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/27.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

final class RecipesViewcontroller: UITableViewController {
    
    // MARK: - Properties
    
    private let dataSource = RecipesDataSource()
    var viewModel: RecipesViewModel?
    private var recipe: RecipeRepresentable?
    var coreDataManager: CoreDataManager?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: Constant.cellNibName, bundle: nil), forCellReuseIdentifier: Constant.reusableCell)
        
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        bind()
        viewModel?.viewDidLoad()
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
                    self?.performSegue(withIdentifier: Constant.toDescription, sender: nil)
                }
            }
        
        dataSource.didSelectRecipeAtIndex = viewModel?.didSelectRecipe
    }
    

    
    // TODO: - In viewModel

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.toDescription {
            let vcDestination = segue.destination as! DescriptionController

            viewModel?.prepareForSegue()
            vcDestination.recipeRepresentable = viewModel?.recipeRepresentable
        }
    }
}
