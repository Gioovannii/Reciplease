//
//  Network Service.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/31.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import Foundation
import Alamofire

protocol AlamoSession {
    func request(with url: URL, callback: @escaping (DataResponse<Any>) -> Void)
}

final class EdanamSession: AlamoSession {
    func request(with url: URL, callback: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            callback(responseData)
        }
    }
}
