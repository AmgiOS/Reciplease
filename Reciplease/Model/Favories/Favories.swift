//
//  Favories.swift
//  Reciplease
//
//  Created by Amg on 23/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation
import CoreData

class Favories: NSManagedObject {
    static var all: [Favories] {
        let request: NSFetchRequest<Favories> = Favories.fetchRequest()
        guard let favories = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return favories
    }

    static func deleteAllData() {
    let deleteFetchRequest = NSBatchDeleteRequest(fetchRequest: Favories.fetchRequest())
    let _ = try? AppDelegate.viewContext.execute(deleteFetchRequest)
    }
    
    static func someObjectExist(id: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favories")
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
