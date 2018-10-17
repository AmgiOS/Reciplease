//
//  Ingredients.swift
//  Reciplease
//
//  Created by Amg on 05/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import CoreData

class Ingredients: NSManagedObject {
    static var all: [Ingredients] {
        let request: NSFetchRequest<Ingredients> = Ingredients.fetchRequest()
        guard let ingredients = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return ingredients
    }
    
    static func deleteAll() {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: Ingredients.fetchRequest())
        let _ = try? AppDelegate.viewContext.execute(deleteRequest)
    }
}
