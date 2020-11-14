//
//  MockEdanamSession.swift
//  RecipleaseTests
//
//  Created by Giovanni Gaffé on 2020/9/2.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

@testable import Reciplease
import Foundation
import Alamofire

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

final class MockEdanamSession: AlamoSession {
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    func request(with url: URL, callback: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: nil)
        let urlRequest = URLRequest(url: URL(string: "https://api.edamam.com")!)
        callback(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
}
