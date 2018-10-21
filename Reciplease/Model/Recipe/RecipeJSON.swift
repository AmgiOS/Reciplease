//
//  RecipeJSON.swift
//  Reciplease
//
//  Created by Amg on 11/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation

// MARK: - Search Recipe
struct RecipeJSON: Decodable {
    var matches: [Description]
}

struct Description: Decodable {
    var imageUrlsBySize: ImageUrlsBySize
    var recipeName: String
    var ingredients: [String]
    var totalTimeInSeconds: Int
    var rating: Int
    var id: String
}

struct ImageUrlsBySize: Decodable {
    var the90: String
    
    enum CodingKeys: String, CodingKey {
        case the90 = "90"
    }
}

// MARK: - Get Recipe
struct Details: Decodable {
    var totalTime: String
    var images: [Image]
    var name: String
    var source: Source
    var ingredientLines: [String]
    var rating: Int
}

struct Image: Decodable {
    var hostedLargeURL: String
    var imageUrlsBySize: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case hostedLargeURL = "hostedLargeUrl"
        case imageUrlsBySize
    }
}

struct Source: Decodable {
    let sourceRecipeURL: String
    
    enum CodingKeys: String, CodingKey {
        case sourceRecipeURL = "sourceRecipeUrl"
    }
}
