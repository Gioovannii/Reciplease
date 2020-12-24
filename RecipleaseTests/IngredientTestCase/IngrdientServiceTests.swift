//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Giovanni Gaffé on 2020/8/24.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import XCTest

@testable import Reciplease

class IngrdientServiceTests: XCTestCase {
    let service = IngredientService()
    
    func testWhenIngredientsIsAdded() {
        service.addIngredients(name: "Lemon")
        XCTAssertTrue(service.ingredients.capacity == 1)
        XCTAssertTrue(!service.ingredients.isEmpty)
        XCTAssertTrue(service.ingredients.first == "Lemon")
    }

    func testWhenIngredientIsAddedFonctionShouldReturn() {
        service.addIngredients(name: "Lime")
        service.addIngredients(name: "Lime")
        XCTAssertTrue(service.ingredients.first == "Lime")
    }
    
    func testWhenIngredientsIsRemove() {
        service.addIngredients(name: "Pear")
        service.clearAllIngredients()
        XCTAssertTrue(service.ingredients.isEmpty)
    }
    
    func testWhenIngredientsIsDelete() {
        service.addIngredients(name: "Pumpkin")
        service.deleteIngredient(at: 0)
        XCTAssertTrue(service.ingredients.first == nil)
        XCTAssertTrue(service.ingredientList.isEmpty)
        print(service.ingredients)
    }
}
