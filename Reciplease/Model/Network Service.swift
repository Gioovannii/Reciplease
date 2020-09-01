//
//  Network Service.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/31.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    func fetchJsonData() {
        Alamofire.request("https://api.edamam.com/search?q=apple&app_key=f6a63dce852eac00b3eb7ac4bf3d54bd&app_id=c3b651ca&count=21&from=0&to=2").validate(statusCode: 200..<300).responseJSON { response in
            guard response.result.isSuccess else {
                print("Error while fetching tags: \(String(describing: response.result.error))")
                return
            }
            
            let data = response.data
            
            guard let responseDecoded = try? JSONDecoder().decode(EdanamJSON.self, from: data!) else { return
            }
            print("Recipe label: \(responseDecoded.hits[0].recipe.label)")
            print("Ingredients: \(responseDecoded.hits[0].recipe.ingredientLines)")
            print("Time: \(responseDecoded.hits[0].recipe.totalTime)min")
            print("Diet: \(responseDecoded.hits[0].recipe.dietLabels)")
        }
    }
}
