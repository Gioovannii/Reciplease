//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/31.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeTableViewCell: UITableViewCell {
    
    // MARK: - Property

    var coreDataManager: CoreDataManager?
    
    // MARK: - Outlet

    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var timeRecipeLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var informationView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recipeView.layer.borderWidth = 1
        recipeView.layer.borderColor = UIColor.black.cgColor
        recipeView.layer.cornerRadius = 10
        recipeView.layer.masksToBounds = true
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 10
    }
    
    var recipe: Recipe? {
        didSet {
            guard let url = URL(string: recipe?.image ?? "chef") else { return }
            guard let recipeUnwrapped = recipe else { return }
            guard let health = recipeUnwrapped.healthLabels.first else { return }
            guard let recipe = recipe else { return }
            recipeImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "chef"),
                                        options: [], completed: nil)
            
            titleLabel.text = recipe.label
            ingredientsLabel.text = recipe.ingredientLines.joined(separator: ", ")
            timeRecipeLabel.text = Double().convert(minutes: Double(recipe.totalTime))
            healthLabel.text = health
        }
    }
    
    var recipeEntity: RecipeEntity? {
        didSet {
            titleLabel.text = recipeEntity?.title
            healthLabel.text = recipeEntity?.healthLabel
            timeRecipeLabel.text = recipeEntity?.time
            ingredientsLabel.text = recipeEntity?.ingredients?.joined(separator: ", ")
            if let imageData = recipeEntity?.image {
                recipeImageView.image = UIImage(data: imageData)
            } else {
                recipeImageView.image = UIImage(named: "chef")
            }
        }
    }
}
