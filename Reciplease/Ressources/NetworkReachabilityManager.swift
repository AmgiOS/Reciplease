//
//  NetworkReachabilityManager.swift
//  Reciplease
//
//  Created by Amg on 18/11/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Alamofire

class NetworkState {
    static func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
