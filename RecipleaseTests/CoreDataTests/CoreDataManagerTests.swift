//
//  CoreDataManagerTests.swift
//  RecipleaseTests
//
//  Created by Giovanni Gaffé on 2020/11/7.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

@testable import Reciplease
import XCTest

final class CoreDataManagerTests: XCTestCase {

    // MARK: - Properties

    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!

    //MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }

    // MARK: - Tests

    func testAddCreateRecipeMethods_WhenAnEnntityIsCreated_ThenShouldBeSaved() {
        coreDataManager.createRecipe(title: "Strawberry tart", health: "Vegetarien", time: "1.3", ingredients: ["Strawberry", "pate"], shareAs: "SomeUrl", image: "image".data)
        XCTAssertTrue(!coreDataManager.recipes.isEmpty)
        XCTAssertTrue(coreDataManager.recipes.count == 1)
        XCTAssertTrue(coreDataManager.recipes[0].title == "Strawberry tart")
    }
    
    func testIsRecipeRegistered_WhenEntityCreated_ThenShouldBeFoundByName() {
        coreDataManager.createRecipe(title: "Strawberry tart", health: "Vegetarien", time: "1.3", ingredients: ["Strawberry", "pate"], shareAs: "SomeUrl", image: "image".data)
        guard let titleRecipe = coreDataManager.recipes[0].title else { return }
        let isRegistered = coreDataManager.isRecipeRegistered(for: titleRecipe)
        XCTAssertTrue(isRegistered)
    }
}
