//
//  NetworkError.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/9/6.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noData
    case incorrectResponse
    case undecodableData
    
    var description: String {
        switch self {
        case .noData:
            return "There is no data"
        case .incorrectResponse:
            return "There is no response"
        case .undecodableData:
            return "Data is undecodable"
        }
    }
}
