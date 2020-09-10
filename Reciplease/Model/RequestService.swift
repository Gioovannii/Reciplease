//
//  RequestService.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/9/2.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import Foundation

final class RequestService {
    
    private let session: AlamoSession
    
    init(session: AlamoSession = EdanamSession()) {
        self.session = session
    }
    
    func getData(ingredients: String, callback: @escaping (Result<EdanamJSON, Error>) -> Void) {
        guard let url = URL(string: "https://api.edamam.com/search?q=\(ingredients)&app_key=\(K.Config.appKey)&app_id=\(K.Config.appId)&from=0&to=10") else { return }
        
        session.request(with: url) { responseData in
            guard let data = responseData.data else {
                callback(.failure(NetworkError.noData))
                return
            }
            
            guard responseData.response?.statusCode == 200 else {
                callback(.failure(NetworkError.incorrectResponse))
                return
            }
            
            guard let responseDecoded = try? JSONDecoder().decode(EdanamJSON.self, from: data) else {
                callback(.failure(NetworkError.undecodableData))
                return
            }
        
            callback(.success(responseDecoded))
        }
    }
}
