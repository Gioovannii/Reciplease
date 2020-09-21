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
    
    @IBAction private func addIngredient(_ sender: UIButton) {
        guard let str = ingredientTextField.text else { return }
        let array = str.components(separatedBy: " ")
        print(array)
        let ingredients = str.trimmingCharacters(in: .whitespacesAndNewlines)
        ingredientTextField.text = ""
        service.addIngredients(name: ingredients)
        ingredientsTableView.reloadData()
    }
    
    @IBAction private func clearIngredientsButton(_ sender: UIButton) {
        service.clearAllIngredients()
        ingredientsTableView.reloadData()
    }
    
    @IBAction private func searchRecipesButton(_ sender: UIButton) {
        
        guard let url = URL(string: "https://api.edamam.com/search?") else { return }
        request.getData(ingredients: service.ingredientList, baseUrl: url, parameters: [("app_id", K.Config.appId), ("app_key", K.Config.appKey), ("q", service.ingredientList)]) { [unowned self] (result: Result<EdanamJSON, NetworkError>) in
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
    
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToRecipe" {
            let vcDestination = segue.destination as! RecipesViewcontroller
            vcDestination.recipes = collectData
        }
    }
}

// MARK: - UITableView DataSource

extension AddIngredientsController: UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            service.deleteIngredient(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
        }
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.ingredients.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredientCell = ingredientsTableView.dequeueReusableCell(withIdentifier: K.ingredient, for: indexPath)
        
        ingredientCell.textLabel?.text = service.ingredients[(indexPath.row)]
        ingredientCell.textLabel?.textColor = UIColor.white
        ingredientCell.textLabel?.font = UIFont(name: K.papyrusFont, size: 20)
        return ingredientCell
    }
}
