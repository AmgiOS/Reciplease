//
//  Ingredient.swift
//  Reciplease
//
//  Created by Amg on 25/11/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import CoreData

class Ingredient: NSManagedObject {
    static var all: [Ingredient] {
        let request: NSFetchRequest<Ingredient> = Ingredient.fetchRequest()
        guard let favories = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return favories
    }
    
    static func deleteAllIngredients() {
        let deleteFetchRequest = NSBatchDeleteRequest(fetchRequest: Ingredient.fetchRequest())
        let _ = try? AppDelegate.viewContext.execute(deleteFetchRequest)
    }
}
