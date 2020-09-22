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
    
    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var timeRecipeLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    var check = true
    override func awakeFromNib() {
        super.awakeFromNib()
        recipeView.layer.borderWidth = 3
        recipeImageView.layer.borderWidth = 3
        recipeView.layer.borderColor = UIColor.black.cgColor
        recipeView.layer.cornerRadius = 10
    }
    
    var recipe: Recipe? {
        didSet {
            guard let url = URL(string: recipe?.image ?? "chef") else { return }
            
            recipeImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "chef"),
                                        options: [], completed: nil)
            titleLabel.text = recipe?.label
            ingredientsLabel.text = recipe?.ingredientLines.joined(separator: ", ")
            timeRecipeLabel.text =  convert(minutes: Double(recipe!.totalTime))
            healthLabel.text = recipe?.healthLabels[0]
        }
    }
    
    // TODO: - change bookmark from recipe
    @IBAction func favoriteTapButton(_ sender: UIButton) {
        if check == true {
            print("NADA")
        } else {
            
        }
        
        check = !check

        switch check {
        case true:
            favoriteButton.setImage(UIImage(named: "fullHeart"), for: .normal)
        case false:
            favoriteButton.setImage(UIImage(named: "emptyHeart"), for: .normal)
        }
    }
    
    // MARK: - Convert time minutes to hours
    
    func convert(minutes: Double) -> String {
        minLabel.isHidden = true
        timeRecipeLabel.font = UIFont(name: "Helvetica", size: 10)
        let formater = NumberFormatter()
        formater.maximumFractionDigits = 2
        
        guard minutes != 0 else { return "Unavailable" }
        guard minutes > 59 else {
            minLabel.isHidden = false
            let minTrans = formater.string(from: NSNumber(value: minutes))
            return minTrans!
        }
        
        let result = minutes / 60
        guard let resultForm = formater.string(from: NSNumber(value: result)) else { return String()}
        return "\(resultForm) hours"
    }
}
