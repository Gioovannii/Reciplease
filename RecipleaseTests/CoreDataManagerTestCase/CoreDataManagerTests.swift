//
//  CoreDataManagerTests.swift
//  RecipleaseTests
//
//  Created by Giovanni Gaffé on 2020/11/7.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class CoreDataManagerTests: XCTestCase {
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
        super.init()
    }
}
