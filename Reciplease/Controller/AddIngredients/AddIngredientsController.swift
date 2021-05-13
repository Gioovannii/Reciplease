//
//  AddIngredientsController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/24.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

final class AddIngredientsController: UIViewController {
    
    
    var viewModel: AddIngredientsViewModel?
    
    // MARK: - Properties
    
    private let request: RequestService = RequestService()
    private var recipes = [Hit]()
    private let dataSource = AddIngredientDataSource()
    
    @IBOutlet weak var addIngredientsButton: UIButton!
    @IBOutlet weak var clearIngredientButton: UIButton!
    
    @IBOutlet private weak var ingredientTextField: UITextField!
    @IBOutlet private weak var ingredientsTableView: UITableView!
    @IBOutlet private weak var searchForRecipesButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonArray = [addIngredientsButton, clearIngredientButton, searchForRecipesButton]
        buttonArray.forEach {
            $0?.layer.cornerRadius = 10
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        isSearching(result: true)
        
        ingredientsTableView.dataSource = dataSource
        ingredientsTableView.delegate = dataSource
        viewModel = AddIngredientsViewModel()
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func bind() {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.recipeSegue {
            guard let vcDestination = segue.destination as? RecipesViewcontroller else { return }
            vcDestination.viewModel = RecipesViewModel(recipes: recipes)
        }
    }
    
    @objc private func dismissKeyboard() { view.endEditing(true) }
    
    @IBAction private func addIngredient(_ sender: UIButton) {
        guard let ingredient = ingredientTextField.text else { return }
        let ingredients = ingredient.trimmingCharacters(in: .whitespacesAndNewlines)
        ingredientTextField.text = ""
        viewModel?.addIngredient(name: ingredients)
        ingredientsTableView.reloadData()
    }
    
    @IBAction private func clearIngredientsButton(_ sender: UIButton) {
        viewModel?.clearAllIngredients()
        ingredientsTableView.reloadData()
    }
    
    @IBAction private func searchRecipesButton(_ sender: UIButton) { viewModel?.searchRecipes() }
 
    private func isSearching(result: Bool) {
        switch result {
        case true:
            activityIndicator.isHidden = true
            searchForRecipesButton.isHidden = false
            
        case false:
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            searchForRecipesButton.isHidden = true
            viewModel?.messageAlert = { message in
                self.presentAlert(title: "", message: message)
            }
        }
    }
}

