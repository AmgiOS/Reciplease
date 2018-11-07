//
//  RecipeSession.swift
//  Reciplease
//
//  Created by Amg on 16/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation
import Alamofire

class RecipeSession: RecipeProtocol {
    func request(url: URL, method: HTTPMethod?, parameters: Parameters?, encoding: URLEncoding?, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url, method: .get
            , parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                completionHandler(response)
        }
    }
}
