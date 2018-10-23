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
}
