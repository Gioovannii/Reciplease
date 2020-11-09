//
//  EdanamJSON.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/30.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import Foundation

// MARK: - EdanamJSON

struct EdanamJSON: Decodable {
    let q: String
    let hits: [Hit]
}

// MARK: - Hit

struct Hit: Decodable {
    let recipe: Recipe
}

// MARK: - Recipe

struct Recipe: Decodable {
    let label: String
    var image: String
    let url: String
    let healthLabels, ingredientLines: [String]
    let totalTime: Int
    let shareAs: String
}

struct RecipeRepresentable {
    let label: String
    var imageData: Data?
    let healthLabels: String
    let ingredientLines: [String]
    let totalTime: String
    let shareAs: String
}
