//
//  RecipeService.swift
//  Reciplease
//
//  Created by Amg on 11/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation
import Alamofire

class RecipeService {
    
    //MARK: - Session
    private var recipeSession: RecipeSession
    init(recipeSession: RecipeSession = RecipeSession()) {
        self.recipeSession = recipeSession
    }
    
    //MARK: - Functions
    private func urlRecipeApi(ingredients: [String]) -> String {
        var parameters = String()
        for (index, value) in ingredients.enumerated() {
            if index == 0 {
                parameters += UrlApi.parametersIngredients + "\(value)"
            } else {
                parameters += UrlApi.parametersIngredients + "\(value)"
            }
        }
        let request = UrlApi.BASE_URL + UrlApi.APP_ID + UrlApi.APP_KEY + parameters
        return request
    }
    
    func getRecipe(ingredients: [String], callback: @escaping (Bool, RecipeJSON?) -> Void ) {
        guard let url = URL(string: urlRecipeApi(ingredients: ingredients)) else { return }
        print(url)
        recipeSession.request(url: url) { (response) in
            switch response.result {
            case .success:
                guard let data = response.data, response.error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response.response, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(RecipeJSON.self, from: data) else {
                    callback(false, nil)
                    return
                }
                print(responseJSON.matches)
                callback(true, responseJSON)
                
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
}
