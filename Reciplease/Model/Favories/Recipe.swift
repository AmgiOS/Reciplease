//
//  Favories.swift
//  Reciplease
//
//  Created by Amg on 23/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import CoreData

class Recipe: NSManagedObject {
    static var all: [Recipe] {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        guard let favories = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return favories
    }

    static func deleteAllData() {
    let deleteFetchRequest = NSBatchDeleteRequest(fetchRequest: Recipe.fetchRequest())
    let _ = try? AppDelegate.viewContext.execute(deleteFetchRequest)
    }
    
    static func someObjectExist(id: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        let predicate = NSPredicate(format: "name == %@", id)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        var entitiesCount = 0
        
        do {
            entitiesCount = try AppDelegate.viewContext.count(for: fetchRequest)
        } catch {
            print("error executing fetch request")
        }
        return entitiesCount > 0
    }
}
