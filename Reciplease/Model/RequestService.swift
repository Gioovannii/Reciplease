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
    private let service = IngredientService()
    init(session: AlamoSession = EdanamSession()) {
        self.session = session
    }
    
    func getData(ingredients: String, callback: @escaping (Result<EdanamJSON, NetworkError>) -> Void) {
        
        guard let baseUrl = URL(string: "https://api.edamam.com/search?") else { return }
        let parameters = [("app_id", Constant.Config.appId), ("app_key", Constant.Config.appKey), ("q", ingredients)]
        let url = encode(baseUrl: baseUrl, with: parameters)
        
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
    
    /// Encoding
    /// - Parameters:
    ///   - baseUrl: Without any parameters
    ///   - parameters: Differents api provide by API
    /// - Returns: Final complete url
    private func encode(baseUrl: URL, with parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false), let parameters = parameters, !parameters.isEmpty else { return baseUrl }
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let querryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(querryItem)
        }
        guard let url = urlComponents.url else { return baseUrl }
        return url
    }
}
