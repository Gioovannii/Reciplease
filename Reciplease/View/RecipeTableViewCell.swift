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
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    
    
    var recipe: Recipe? {
        didSet {
            recipeImageView.load(url: URL(string: recipe!.image)!)
            titleLabel.text = recipe?.label
            ingredientsLabel.text = recipe?.ingredientLines.joined(separator: ", ")
            timeRecipeLabel.text =  convert(minutes: Double(recipe!.totalTime))
            healthLabel.text = recipe?.healthLabels[0]
        }
    }
    
    @IBAction func favoriteTapButton(_ sender: UIButton) { }
    
    func convert(minutes: Double) -> String {
        minLabel.isHidden = true
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

// MARK: - Load image from url

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

