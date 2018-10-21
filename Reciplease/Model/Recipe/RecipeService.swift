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
    private var detailsSession: RecipeSession
    init(recipeSession: RecipeSession = RecipeSession(), detailsSession: RecipeSession = RecipeSession()) {
        self.recipeSession = recipeSession
        self.detailsSession = detailsSession
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
                callback(true, responseJSON)
                
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }

    
    private func urlDetailsApi(id: String) -> String {
        let url = UrlDetailsApi.BASE_URL + id + UrlDetailsApi.APP_ID + UrlDetailsApi.APP_KEY
        return url
    }
    
    func getDetailsRecipe(id: String, callback: @escaping (Bool, Details?) -> Void) {
        guard let url = URL(string: urlDetailsApi(id: id)) else { return }
        print(url)
        detailsSession.request(url: url) { (response) in
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
                guard let responseJSON = try? JSONDecoder().decode(Details.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON)
                
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
}
