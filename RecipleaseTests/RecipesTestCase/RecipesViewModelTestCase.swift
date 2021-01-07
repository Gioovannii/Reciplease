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
    
    // MARK: - Set Array with some recipes

    var recipes = [
        Hit(recipe: Recipe(label: "Lemon Confit", image: "https://www.edamam.com/web-img/d32/d32b4dc2e7bd9d4d1a24bbced0c89143.jpg", url: "http://ruhlman.com/2011/03/lemon-confit/",
                           healthLabels: ["Vegan", "Vegetarian", "Peanut-Free", "Tree-Nut-Free", "Alcohol-Free", "Immuno-Supportive"],
                           ingredientLines: ["Kosher salt to cover (about 2 pounds/900 grams)",
                                             "1/2 to 1 cup water or lemon juice (125 to 250 ml)","6 lemons, scrubbed and halved crosswise"],
                           totalTime: 0,
                           shareAs: "http://www.edamam.com/recipe/lemon-confit-2fb391cceeec3d82920a2035f1849d72/lemon")),
        
        Hit(recipe: Recipe(label: "Lemon Sorbet", image: "https://www.edamam.com/web-img/78e/78ef0e463d0aadbf2caf7b6237cd5f12.jpg",
                           url: "http://www.bbcgoodfood.com/recipes/4583/",
                           healthLabels: ["Vegan", "Vegetarian", "Peanut-Free", "Tree-Nut-Free", "Alcohol-Free"],
                           ingredientLines: ["500.0g caster sugar", "1 lemon , unwaxed, zested", "250 ml lemon juice (6-8 lemons)"],
                           totalTime: 0, shareAs: "http://www.edamam.com/recipe/lemon-sorbet-9199ad45bd7fb16cda8d08c3e30771c2/lemon")),
        
        Hit(recipe: Recipe(label: "Lemon Icey", image: "https://www.edamam.com/web-img/2c0/2c0ac2c82407335d6141e699a7442164.jpg",
                           url: "https://www.marthastewart.com/868405/lemon-icey",
                           healthLabels: ["Vegan", "Vegetarian", "Peanut-Free", "Tree-Nut-Free", "Alcohol-Free"],
                           ingredientLines: ["1 cup lemon juice (from 5-6 lemons)", "1 cup simple syrup"],
                           totalTime: 0, shareAs: "http://www.edamam.com/recipe/lemon-icey-2a04bbc6d5ae6a8c4a02368a79ffc2e5/lemon")),
        
        Hit(recipe: Recipe(label: "Baking with Dorie: Lemon-Lemon Lemon Cream Recipe", image: "https://www.edamam.com/web-img/fdb/fdbace4ccbbfc9b571035f0e3882f300.jpg",
                           url: "http://www.seriouseats.com/recipes/2008/04/lemon-lemon-lemon-cream-recipe.html",
                           healthLabels: ["Vegetarian", "Peanut-Free", "Tree-Nut-Free", "Alcohol-Free"],
                           ingredientLines: ["1 cup sugar", "Finely grated zest of 3 lemons", "4 large eggs", "3/4 cup freshly squeezed lemon juice (from 4 to 5 lemons)", "2 sticks plus 5 tablespoons (21 tablespoons; 10 1/2 ounces) unsalted butter, at room temperature and cut into tablespoon-sized pieces", "1 fully-baked 9-inch tart shell"],
                           totalTime: 0, shareAs: "http://www.edamam.com/recipe/baking-with-dorie-lemon-lemon-lemon-cream-recipe-4f9c800cacf043bc069c47edab62d520/lemon"))]
    
    
    func testDidSetRecipe() {
        let viewModel = RecipesViewModel(recipes: recipes)
        
        viewModel.recipes = recipes
    }
}
