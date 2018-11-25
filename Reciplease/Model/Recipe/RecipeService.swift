//
//  RecipeService.swift
//  Reciplease
//
//  Created by Amg on 11/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation

class RecipeService {
    
    //MARK: - Session
    private var recipeSession: RecipeSession
    init(recipeSession: RecipeSession = RecipeSession()) {
        self.recipeSession = recipeSession
    }
    
    //MARK: - Functions
    func getRecipe(ingredients: [String], completionHandler: @escaping (Bool, RecipeJSON?) -> Void ) {
        guard let url = URL(string: recipeSession.urlStringApi) else { return }
        let parameters = ["q": ingredients]
        recipeSession.request(url: url, method: .get, parameters: parameters) { response in
            guard response.response?.statusCode == 200, response.error == nil else {
                completionHandler(false, nil)
                return
            }
            guard let data = response.data else {
                completionHandler(false, nil)
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(RecipeJSON.self, from: data) else {
                completionHandler(false, nil)
                return
            }
            completionHandler(true, responseJSON)
        }
    }
    
    private func urlDetailsApi(id: String) -> String {
        let url = recipeSession.urlStringDetails + id + recipeSession.urlStringDetailsKey
        return url
    }
    func getDetailsRecipe(id: String, completionHandler: @escaping (Bool, Details?) -> Void) {
        guard let url = URL(string: urlDetailsApi(id: id)) else { return }
        recipeSession.request(url: url, method: .get, parameters: nil) { response in
            guard response.response?.statusCode == 200, response.error == nil else {
                completionHandler(false, nil)
                return
            }
            guard let data = response.data else {
                completionHandler(false, nil)
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(Details.self, from: data) else {
                completionHandler(false, nil)
                return
            }
            completionHandler(true, responseJSON)
        }
    }
}
