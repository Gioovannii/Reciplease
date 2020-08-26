//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/26.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
   
    func configure(withImage recipe: String, title: String, ingredients: String) {
        recipeImageView.image = UIImage(named: recipe)
        titleLabel.text = title
        ingredientsLabel.text = ingredients
    }
}
