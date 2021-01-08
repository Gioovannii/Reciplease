//
//  FavoriteViewModelTestCase.swift
//  RecipleaseTests
//
//  Created by Giovanni Gaffé on 2020/12/15.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import XCTest
@testable import Reciplease

class FavoriteViewModelTestCase: XCTestCase {

    var recipeRepresentable = RecipeRepresentable(label: "Lemon Confit", imageData: "https://www.edamam.com/web-img/d32/d32b4dc2e7bd9d4d1a24bbced0c89143.jpg".data, healthLabels: "Vegan", ingredientLines: ["Kosher salt to cover (about 2 pounds/900 grams)","1/2 to 1 cup water or lemon juice (125 to 250 ml)","6 lemons, scrubbed and halved crosswise"], totalTime: "0", shareAs: "http://www.edamam.com/recipe/lemon-confit-2fb391cceeec3d82920a2035f1849d72/lemon")
    
    
    var coreDataStack: CoreDataStack!
    var coreDataManager: CoreDataManager!

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        coreDataManager = nil
    }
    
    
}
