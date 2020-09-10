//
//  AddIngredientsController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/24.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

final class AddIngredientsController: UIViewController {
    
    // MARK: - Properties
    
    private var service = IngredientService()
    private let request: RequestService = RequestService()
    private var collectData: [Hit]?
    
    @IBOutlet private weak var ingredientTextField: UITextField!
    @IBOutlet private weak var ingredientsTableView: UITableView!
    
    @IBAction func addIngredient(_ sender: UIButton) {
        guard let str = ingredientTextField.text else { return }
        let ingredients = str.trimmingCharacters(in: .whitespacesAndNewlines)
        ingredientTextField.text = ""
        service.addIngredients(name: ingredients)
        ingredientsTableView.reloadData()
    }
    
    @IBAction func clearIngredientsButton(_ sender: UIButton) {
        service.clearAllIngredients()
        ingredientsTableView.reloadData()
    }
    
    @IBAction func searchRecipesButton(_ sender: UIButton) {
        
        request.getData(ingredients: service.ingredientList) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.collectData = data.hits
                    print(self.collectData!)
                    self.performSegue(withIdentifier: "ToRecipe", sender: nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.presentAlert(title: "Error", message: "\(error.localizedDescription)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToRecipe" {
            let vcDestination = segue.destination as! RecipesViewcontroller
            vcDestination.recipes = collectData
        }
    }
}

// MARK: - UITableView DataSource

extension AddIngredientsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            service.deleteIngredient(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredientCell = ingredientsTableView.dequeueReusableCell(withIdentifier: K.ingredient, for: indexPath)
        
        ingredientCell.textLabel?.text = service.ingredients[(indexPath.row)]
        ingredientCell.textLabel?.textColor = UIColor.white
        ingredientCell.textLabel?.font = UIFont(name: K.papyrusFont, size: 20)
        return ingredientCell
    }
}
