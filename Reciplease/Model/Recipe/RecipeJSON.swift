//
//  RecipeJSON.swift
//  Reciplease
//
//  Created by Amg on 11/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation

struct RecipeJSON: Decodable {
    var matches: [Description]
}

struct Description: Decodable {
    var imageUrlsBySize: ImageUrlsBySize
    var recipeName: String
    var ingredients: [String]
    var totalTimeInSeconds: Int
    var rating: Int
}

struct ImageUrlsBySize: Decodable {
    var the90: String
    
    enum CodingKeys: String, CodingKey {
        case the90 = "90"
    }
}
