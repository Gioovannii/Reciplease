//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/31.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var timeRecipeLabel: UILabel!
    @IBOutlet weak var dietLabel: UILabel!
    
    
    var recipe: Recipe? {
        didSet {
            recipeImageView.image = UIImage(named: "pizzaMargherita")
            titleLabel.text = recipe?.label
            ingredientsLabel.text = recipe?.ingredientLines.joined(separator: ", ")
            timeRecipeLabel.text =  String(recipe?.totalTime ?? 0)
            dietLabel.text = recipe?.dietLabels[0]
        }
    }
    
    @IBAction func favoriteTapButton(_ sender: UIButton) { }
}

