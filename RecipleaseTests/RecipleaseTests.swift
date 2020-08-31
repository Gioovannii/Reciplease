//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Giovanni Gaffé on 2020/8/24.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipleaseTests: XCTestCase {
    let service = IngredientService()
    
    func testWhenIngredientsIsAdded() {
        service.addIngredients(name: "Tomatoe")
        XCTAssertTrue(service.ingredients.capacity == 1)
        XCTAssertTrue(!service.ingredients.isEmpty)
        XCTAssertTrue(service.ingredients.first == "Tomatoe")
    }
    
    func testWhenIngredientsIsRemove() {
        service.addIngredients(name: "Pear")
        service.clearAllIngredients()
        XCTAssertTrue(service.ingredients.isEmpty)
    }
}
