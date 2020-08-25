//
//  AddIngredientsController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/24.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

final class AddIngredientsController: UIViewController {
    
    @IBOutlet private weak var ingredientTextField: UITextField!
    @IBOutlet private weak var ingredientsTableView: UITableView!
    
    private var coreDataManager: CoreDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        
        navigationItem.title = "Reciplease"
    }
    
    @IBAction func addIngredient(_ sender: UIButton) {
        guard let ingredient = ingredientTextField.text else { return }
        print(ingredient)
        ingredientTextField.text = ""
        coreDataManager?.createIngredient(name: ingredient)
        ingredientsTableView.reloadData()
    }
    
    @IBAction func clearIngredientsButton(_ sender: UIButton) {
        coreDataManager?.deleteAllIngredients()
        ingredientsTableView.reloadData()
    }
}

extension AddIngredientsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredientCell = ingredientsTableView.dequeueReusableCell(withIdentifier: "Ingredient", for: indexPath)
        ingredientCell.textLabel?.text =  coreDataManager?.ingredients[indexPath.row].name
        ingredientCell.textLabel?.textColor = UIColor.white
        ingredientCell.textLabel?.font = UIFont(name: "Papyrus", size: 20)
        return ingredientCell
    }
}
