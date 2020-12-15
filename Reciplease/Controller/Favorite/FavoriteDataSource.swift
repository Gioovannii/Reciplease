//
//  FavoriteDataSource.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/12/14.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

final class FavoriteDataSource: NSObject {
    
    // MARK: - Properties
    
    var recipes = [RecipeEntity]()
    var didSelectRecipeAtIndex: ((Int) -> Void)?
    
    func update(with recipes: [RecipeEntity]) {
        self.recipes = recipes
    }
}

// MARK: - Table view dataSource

extension FavoriteDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.reusableCell, for: indexPath) as? RecipeTableViewCell else {
            print("Error while loading cell")
            return UITableViewCell()
        }
        
    
        cell.recipeEntity = recipes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectRecipeAtIndex?(indexPath.row)
    }
}

// MARK: - UITableView Delegate

extension FavoriteDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "You need to add some recipes"
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return recipes.isEmpty ? 420 : 0
    }
    
    // MARK: - Cell Animations

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let translationMouvement = CATransform3DTranslate(CATransform3DIdentity, 0, 100, 0)
        cell.layer.transform = translationMouvement
        cell.alpha = 0
        UIView.animate(withDuration: 0.20) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}
