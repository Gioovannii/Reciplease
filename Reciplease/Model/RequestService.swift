//
//  RequestService.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/9/2.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import Foundation

// MARK: - Edanam Error

enum EdanamError: Error {
    case noData, incorrectResponse, undecodable
}

final class RequestService {
    
    private let session: AlamoSession
    
    init(session: AlamoSession = EdanamSession()) {
        self.session = session
    }
    
    func getData(callback: @escaping (Result<EdanamJSON, Error>) -> Void) {
        guard let url = URL(string: "https://api.edamam.com/search?q=apple&app_key=f6a63dce852eac00b3eb7ac4bf3d54bd&app_id=c3b651ca&count=21&from=0&to=2") else { return }
        
        session.request(with: url) { responseData in
            guard let data = responseData.data else {
                callback(.failure(EdanamError.noData))
                return
            }
            
            guard responseData.response?.statusCode == 200 else {
                callback(.failure(EdanamError.incorrectResponse))
                return
            }
            
            guard let responseDecoded = try? JSONDecoder().decode(EdanamJSON.self, from: data) else {
                callback(.failure(EdanamError.undecodable))
                return
            }
            callback(.success(responseDecoded))
        }
    }
}
