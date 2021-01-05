//
//  Double+String.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/10/30.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import Foundation
extension Double {
    func convert(minutes: Self) -> String {
        let formater = NumberFormatter()
        formater.maximumFractionDigits = 2
        
        guard minutes != 0 else { return "Unavailable" }
        guard minutes > 59 else {
            guard let minTrans = formater.string(from: NSNumber(value: minutes)) else { return ""}
            return "\(minTrans) min"
        }
        
        let result = minutes / 60
        guard let resultForm = formater.string(from: NSNumber(value: result)) else { return String() }
        return "\(resultForm) hours"
    }
}


