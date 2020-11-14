//
//  File.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/10/29.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import Foundation

extension String {
    var data: Data? {
        guard let url = URL(string: self) else { return nil }
        guard let data =  try? Data(contentsOf: url) else { return nil }
        return data
    }
}
