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
    func request (url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)
}
