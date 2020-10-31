//
//  EdanamJSON.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/30.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import Foundation

// MARK: - EdanamJSON

struct EdanamJSON: Codable {
    let q: String
    let from, to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit

struct Hit: Codable {
    let recipe: Recipe
    let bookmarked, bought: Bool
}

// MARK: - Recipe

struct Recipe: Codable {
    let uri: String
    let label: String
    var image: String
    let source: String
    let url: String
    let shareAs: String
    let dietLabels, healthLabels, cautions, ingredientLines: [String]
    let totalTime: Int
}

struct RecipeRepresentable {
    var imageData: Data?
    let url: String
    let source: String
    let ingredients: [String]
    let label: String
    let totalTime: String
    let healthLabels: [String]
    let ingredientLines: [String]
    let shareAs: String
}
