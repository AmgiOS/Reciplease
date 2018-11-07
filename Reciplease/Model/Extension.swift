//
//  Constante.swift
//  Reciplease
//
//  Created by Amg on 10/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation

extension String {
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}
