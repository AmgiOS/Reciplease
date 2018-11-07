//
//  RecipeProtocol.swift
//  Reciplease
//
//  Created by Amg on 16/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation
import Alamofire

protocol RecipeProtocol {
    //MARK: - Vars
    var urlStringApi: String { get }
    
    var urlStringDetails: String { get }
    var urlStringDetailsKey: String { get }
    
    //MARK: - Function
    func request (url: URL, method: HTTPMethod?, parameters: Parameters?, encoding: URLEncoding?, completionHandler: @escaping (DataResponse<Any>) -> Void)
}

extension RecipeProtocol {
    var urlStringApi: String {
        let BASE_URL = "http://api.yummly.com/v1/api/recipes?"
        let APP_ID = "_app_id=9d342469"
        let APP_KEY = "&_app_key=a54cf61393ecff9fa2c8094021a5ecac"
        return BASE_URL + APP_ID + APP_KEY
    }
    
    var urlStringDetails: String {
        let BASE_URL = "http://api.yummly.com/v1/api/recipe/"
        return BASE_URL
    }
    
    var urlStringDetailsKey: String {
        let APP_ID = "?_app_id=9d342469"
        let APP_KEY = "&_app_key=a54cf61393ecff9fa2c8094021a5ecac"
        return APP_ID + APP_KEY
    }
}
