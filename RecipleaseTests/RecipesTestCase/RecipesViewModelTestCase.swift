//
//  RecipesViewModelTestCase.swift
//  RecipleaseTests
//
//  Created by Giovanni Gaffé on 2020/12/15.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipesViewModelTestCase: XCTestCase {

//    var recipe = Recipe(label: "", image: <#T##String#>, url: <#T##String#>, healthLabels: <#T##[String]#>, ingredientLines: <#T##[String]#>, totalTime: <#T##Int#>, shareAs: <#T##String#>)
    var recipes = [Hit]()

    func testDidSetRecipe() {
        let viewModel = RecipesViewModel(recipes: self.recipes)
        
        viewModel.recipes = recipes
    }
}
