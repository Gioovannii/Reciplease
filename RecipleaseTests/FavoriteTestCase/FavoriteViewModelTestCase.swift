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
    
    var coreDataStack: CoreDataStack!
    var coreDataManager: CoreDataManager!
    
    
    override func setUp() {
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        coreDataStack = nil
        coreDataManager = nil
    }
    
    
}
