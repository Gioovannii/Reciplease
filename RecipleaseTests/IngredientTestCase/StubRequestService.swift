//
//  StubRequestService.swift
//  RecipleaseTests
//
//  Created by Giovanni Gaffé on 2021/1/4.
//  Copyright © 2021 Jonathan Gaffé. All rights reserved.
//

import Foundation
@testable import Reciplease

class StubRequestService: RequestTestService {
    var result: Result<EdanamJSON, NetworkError>
    
    init(isSuccess: Bool = true) {
        switch isSuccess {
        case true:
            let edanam = EdanamJSON(q: "Lemon", hits: [Hit(recipe: Recipe(label: "Lemon Confit",
                         image: "https://www.edamam.com/web-img/d32/d32b4dc2e7bd9d4d1a24bbced0c89143.jpg",
                         url: "http://ruhlman.com/2011/03/lemon-confit/", healthLabels: ["Vegan", "Vegetarian", "Peanut-Free", "Tree-Nut-Free", "Alcohol-Free", "Immuno-Supportive"],
                         ingredientLines: ["Kosher salt to cover (about 2 pounds/900 grams)",
                                           "1/2 to 1 cup water or lemon juice (125 to 250 ml)",
                        "6 lemons, scrubbed and halved crosswise"], totalTime: 0,
                shareAs: "http://www.edamam.com/recipe/lemon-confit-2fb391cceeec3d82920a2035f1849d72/lemon"))])
          
            result = .success(edanam)
        case false:
            result = .failure(.incorrectResponse)
            print("error")
        }
    }
    
    func getData(ingredients: String, callback: @escaping (Result<EdanamJSON, NetworkError>) -> Void) {
        callback(result)
    }
}
