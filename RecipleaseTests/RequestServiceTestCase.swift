//
//  RequestServiceTestCase.swift
//  RecipleaseTests
//
//  Created by Giovanni Gaffé on 2020/9/2.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

    @testable import Reciplease
    import XCTest

    final class RequestServiceTests: XCTestCase {

        func testGetData_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
            let session = MockEdanamSession(fakeResponse: FakeResponse(response: nil, data: nil))
            let requestService = RequestService(session: session)
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            
            requestService.getData(ingredients: "cheese,mozarella") { result in
                guard case .failure(let error) = result else {
                    XCTFail("Test getData method with no data failed.")
                    return
                }
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)
        }

        func testGetData_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
            let session = MockEdanamSession(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
            let requestService = RequestService(session: session)
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            
            requestService.getData(ingredients: "cheese,mozarella") { result in
                guard case .failure(let error) = result else {
                    XCTFail("Test getData method with incorrect response failed.")
                    return
                }
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)
        }

        func testGetData_WhenUndecodableDataIsPassed_ThenShouldReturnFailedCallback() {
            let session = MockEdanamSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))
            let requestService = RequestService(session: session)
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            requestService.getData(ingredients: "cheese,mozarella") { result in
                guard case .failure(let error) = result else {
                    XCTFail("Test getData method with undecodable data failed.")
                    return
                }
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)
        }

        func testGetData_WhenCorrectDataIsPassed_ThenShouldReturnSuccededCallback() {
            let session = MockEdanamSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
            let requestService = RequestService(session: session)
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            requestService.getData(ingredients: "cheese,mozarella") { result in
                guard case .success(let data) = result else {
                    XCTFail("Test getData method with correct data failed.")
                    return
                }
                XCTAssertTrue(data.hits[0].recipe.label == "Hand Held Syrian Spinach Pies")
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)
        }
    }
