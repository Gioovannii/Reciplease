//
//  RecipesDataSource.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/11/26.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

protocol RecipesListViewControllerDelegate: class {
    func didSelectRecipe(with recipe: Hit)
}
