//
//  DescriptionViewModelTestCase.swift
//  RecipleaseTests
//
//  Created by Giovanni Gaffé on 2020/12/15.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import XCTest
@testable import Reciplease

class DescriptionViewModelTestCase: XCTestCase {
    
       var coreDataStack: CoreDataStack!
       var coreDataManager: CoreDataManager!
    
    // MARK: - Set recipeRepresentable normally push by segue

    var recipeRepresentable = RecipeRepresentable(label: "Lemon Confit", imageData: "https://www.edamam.com/web-img/d32/d32b4dc2e7bd9d4d1a24bbced0c89143.jpg".data, healthLabels: "Vegan", ingredientLines: ["Kosher salt to cover (about 2 pounds/900 grams)","1/2 to 1 cup water or lemon juice (125 to 250 ml)","6 lemons, scrubbed and halved crosswise"], totalTime: "0", shareAs: "http://www.edamam.com/recipe/lemon-confit-2fb391cceeec3d82920a2035f1849d72/lemon")

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
    
    func createRecipe() {
        let viewModel = DescriptionViewModel(recipe: recipeRepresentable, coreDataManager: coreDataManager)

        viewModel.coreDataManager.createRecipe(title: "Lemon Confit", health: "Vegan", time: "0", ingredients: ["Kosher salt to cover (about 2 pounds/900 grams)","1/2 to 1 cup water or lemon juice (125 to 250 ml)","6 lemons, scrubbed and halved crosswise"], shareAs: "http://www.edamam.com/recipe/lemon-confit-2fb391cceeec3d82920a2035f1849d72/lemon",
            image: "https://www.edamam.com/web-img/d32/d32b4dc2e7bd9d4d1a24bbced0c89143.jpg".data)
    }
    
    func testDidSetRecipe_WhenWeChangeValue_ThenWeEnterInside() {
        let viewModel = DescriptionViewModel(recipe: recipeRepresentable, coreDataManager: coreDataManager)
        
        viewModel.recipe = recipeRepresentable
        let expectedResult = "Lemon Confit"
        
        XCTAssert(expectedResult == recipeRepresentable.label)
    }
    
    func testViewDidLoad_WhenViewDidLoadIsCall_ThenWeShouldAssertOneOfIsProperties() {
        let viewModel = DescriptionViewModel(recipe: recipeRepresentable, coreDataManager: coreDataManager)
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        let expectedResult = "Lemon Confit"
       
        viewModel.recipeOutput = { recipe in
            XCTAssert(expectedResult == recipe.label)
            expectation.fulfill()
        }
        
        viewModel.viewDidLoad()
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testFavoriteLoad() {
        let viewModel = DescriptionViewModel(recipe: recipeRepresentable, coreDataManager: coreDataManager)
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        viewModel.isFavoriteOutput = { isFavorite in
            
            switch viewModel.coreDataManager.isRecipeRegistered(for: self.recipeRepresentable.label) {
            case true:
                XCTAssertTrue(isFavorite)
            case false:
                XCTAssertFalse(isFavorite)
            }
            expectation.fulfill()
        }
        viewModel.coreDataManager.createRecipe(title: "Lemon Confit", health: "Vegan", time: "0", ingredients: ["Kosher salt to cover (about 2 pounds/900 grams)","1/2 to 1 cup water or lemon juice (125 to 250 ml)","6 lemons, scrubbed and halved crosswise"], shareAs: "http://www.edamam.com/recipe/lemon-confit-2fb391cceeec3d82920a2035f1849d72/lemon",
            image: "https://www.edamam.com/web-img/d32/d32b4dc2e7bd9d4d1a24bbced0c89143.jpg".data)
        viewModel.favoriteLoad()
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testIsRecipeRegistered() {
        let viewModel = DescriptionViewModel(recipe: recipeRepresentable, coreDataManager: coreDataManager)
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        viewModel.isFavoriteOutput = { isFavorite in
                XCTAssertTrue(isFavorite)
                expectation.fulfill()
        }
        viewModel.tapFavorite()
        wait(for: [expectation], timeout: 0.01)
    }
}
