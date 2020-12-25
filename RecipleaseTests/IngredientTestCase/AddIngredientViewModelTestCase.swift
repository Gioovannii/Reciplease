//
//  AddIngredientViewModelTestCase.swift
//  RecipleaseTests
//
//  Created by Giovanni Gaffé on 2020/12/15.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import XCTest
@testable import Reciplease

class AddIngredientViewModelTestCase: XCTestCase {

    // MARK: - Ingredient List
 
    func testAddIngredient_WhenIngredientsIsAdded_ThenShouldReturnListTransform() {
        let session = MockEdanamSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK))
        let requestService = RequestService(session: session)
        let viewModel = AddIngredientsViewModel(service: requestService)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        let expectedResult = ["- Tomatoe"]
        viewModel.ingredientsList = { ingredients in
            XCTAssert(expectedResult == ingredients)
            expectation.fulfill()
        }
        viewModel.addIngredient(name: "Tomatoe")
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testDeleteIngredient_WhenIngredientIsDelete_ThenItShouldNotBeHere() {
        let session = MockEdanamSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK))
        let requestService = RequestService(session: session)
        let viewModel = AddIngredientsViewModel(service: requestService)
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        let expectedResult = [String]()
        viewModel.addIngredient(name: "Tomatoe")
        viewModel.ingredientsList = { ingredients in
            XCTAssert(expectedResult == ingredients)
            expectation.fulfill()
        }
        viewModel.deleteIngredient(index: 0)
        wait(for: [expectation], timeout: 0.01)
    }
    
   
}
