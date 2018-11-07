//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Amg on 21/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation
import Alamofire

class FakeResponseData {
    
    //MARK: - Fake Response data
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)

    //MARK: - Error
    class NetworkError: Error {}
    static let error = NetworkError()
    
    //MARK: - Correct Data
    static var recipeCorrect: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var detailsCorrect: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "RecipeDetail", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    //MARK: - Incorrect Data
    static let incorrectData = "error".data(using: .utf8)!
}
