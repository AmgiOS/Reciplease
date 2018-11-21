//
//  NetworkReachabilityManager.swift
//  Reciplease
//
//  Created by Amg on 18/11/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation
import Alamofire

class NetworkState {
    class func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
