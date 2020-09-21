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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recipeView.layer.borderWidth = 3
        recipeImageView.layer.borderWidth = 3
        recipeView.layer.borderColor = UIColor.black.cgColor
        recipeView.layer.cornerRadius = 10
    }
    
    var recipe: Recipe? {
        didSet {
            recipeImageView.load(url: URL(string: recipe!.image)!)
            titleLabel.text = recipe?.label
            ingredientsLabel.text = recipe?.ingredientLines.joined(separator: ", ")
            timeRecipeLabel.text =  convert(minutes: Double(recipe!.totalTime))
            healthLabel.text = recipe?.healthLabels[0]
        }
    }
    
    // TODO: - Send user to safari web site
    @IBAction func favoriteTapButton(_ sender: UIButton) { }

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


// MARK: - Load image from url

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func load(url: URL) {
        self.image = nil // Set previous image to blank then load
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                let imageToCache = UIImage(data: data)
                //imageCache.setObject(imageToCache!, forKey: url)
                if let image = imageToCache {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

