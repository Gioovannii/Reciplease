//
//  AddIngredientsController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/24.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

final class AddIngredientsController: UIViewController {
    
    
    // TODO: - Instantiate controller with viewModel property from AddIngredientsViewModel
    var viewModel: AddIngredientsViewModel?
    
    // MARK: - Properties
    
    private let request: RequestService = RequestService()
    private var recipes = [Hit]()
    private let dataSource = AddIngredientDataSource()
    
    
    @IBOutlet private weak var ingredientTextField: UITextField!
    @IBOutlet private weak var ingredientsTableView: UITableView!
    @IBOutlet weak var searchForRecipesButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        isSearching(result: true)
        ingredientsTableView.dataSource = dataSource
        viewModel = AddIngredientsViewModel()
        bind()
        viewModel?.viewDidLoad()
    }
    
    func bind() {
        viewModel?.ingredientsList = { ingredients in
            self.dataSource.update(with: ingredients)
            self.ingredientsTableView.reloadData()
        }
        dataSource.deleteIngredientWithIndex = viewModel?.deleteIngredient
        
        viewModel?.recipes = { recipes in
            self.performSegue(withIdentifier: "toRecipe", sender: nil)
        }
        
        viewModel?.isSearching = isSearching
        
        viewModel?.recipes = { [weak self] recipe in
            DispatchQueue.main.async {
                self?.recipes = recipe
                self?.performSegue(withIdentifier: Constant.recipeSegue, sender: nil)
            }
        }
    }
    
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.recipeSegue {
            guard let vcDestination = segue.destination as? RecipesViewcontroller else { return }
            vcDestination.recipes = self.recipes
        }
    }
    
    @objc func dismissKeyboard() { view.endEditing(true) }
    
    @IBAction private func addIngredient(_ sender: UIButton) {
        guard let str = ingredientTextField.text else { return }
        let ingredients = str.trimmingCharacters(in: .whitespacesAndNewlines)
        ingredientTextField.text = ""
        viewModel?.addIngredient(name: ingredients)
        ingredientsTableView.reloadData()
        
    }
    
    @IBAction private func clearIngredientsButton(_ sender: UIButton) {
        viewModel?.clearAllIngredients()
        ingredientsTableView.reloadData()
    }
    
    @IBAction private func searchRecipesButton(_ sender: UIButton) { viewModel?.searchRecipes() }
 
    func isSearching(result: Bool) {
        switch result {
        case true:
            activityIndicator.isHidden = true
            searchForRecipesButton.isHidden = false
        case false:
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            searchForRecipesButton.isHidden = true
        }
    }
}

