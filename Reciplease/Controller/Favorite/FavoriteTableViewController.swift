//
//  FavoriteTableViewCOntrollerTableViewController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/9/23.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

final class FavoriteTableViewController: UITableViewController {
    
    var viewModel: FavoriteViewModel?
    private let dataSource = FavoriteDataSource()
    private var coreDataManager: CoreDataManager?
    private var recipe: RecipeRepresentable?
    
    //var recipeRepresentable: RecipeRepresentable?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewDidLoad()
        print("Load recipes \(String(describing: coreDataManager?.recipes[0].title))")
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // print("Load recipes   \(String(describing: coreDataManager?.recipes.last!)) as Any")
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        //bind()
        
        self.tableView.register(UINib(nibName: Constant.cellNibName, bundle: nil), forCellReuseIdentifier: Constant.reusableCell)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataManager = CoreDataManager(coreDataStack: appDelegate.coreDataStack)
        bind()
        //viewModel?.viewDidLoad()
    }
    
    func bind() {
        
        viewModel?.recipesOutput = { [weak self] recipes in
            DispatchQueue.main.async {
                print(recipes)
                self?.dataSource.update(with: self!.coreDataManager!.recipes)
                self?.tableView.reloadData()
            }
        }
        
        viewModel?.recipeOutput = { [weak self] recipe in
            DispatchQueue.main.async {
                print(recipe)
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

//    // MARK: - Table view data source
//extension FavoriteTableViewController {
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return coreDataManager?.recipes.count ?? 0
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.reusableCell, for: indexPath) as? RecipeTableViewCell else {
//            print("Error while loading cell")
//            return UITableViewCell()
//        }
//
//        cell.recipeEntity = coreDataManager?.recipes[indexPath.row]
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 260
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let recipe = coreDataManager?.recipes[indexPath.row] else { return }
//        recipeRepresentable = RecipeRepresentable(label: recipe.title ?? "", imageData: recipe.image, healthLabels: recipe.healthLabel ?? "", ingredientLines: recipe.ingredients ?? [], totalTime: recipe.time ?? "", shareAs: recipe.shareAs ?? "")
//        performSegue(withIdentifier: Constant.toDescription, sender: nil)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == Constant.toDescription {
//            let vcDestination = segue.destination as! DescriptionController
//
//            guard let recipeRepresentable = recipeRepresentable else { return }
//            guard let coreDataManager = coreDataManager else { return }
//
//            vcDestination.viewModel = DescriptionViewModel(recipe: recipeRepresentable, coreDataManager: coreDataManager)
//        }
//    }
//}
//
//// MARK: - UITableView Delegate
//
//extension FavoriteTableViewController {
//
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let label = UILabel()
//        label.text = "You need to add some recipes"
//        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
//        label.textAlignment = .center
//        label.textColor = .darkGray
//        return label
//    }
//
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return coreDataManager?.recipes.isEmpty ?? true ? 420 : 0
//    }
//}

