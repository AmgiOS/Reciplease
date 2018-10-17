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
    var imageUrlsBySize: ImagesUrl
    var recipeName: String
    var ingredients: [String]
}

struct ImagesUrl: Decodable {
    
}
