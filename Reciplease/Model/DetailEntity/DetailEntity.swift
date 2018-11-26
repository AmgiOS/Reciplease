//
//  Details.swift
//  Reciplease
//
//  Created by Amg on 26/11/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import Foundation
import CoreData

class DetailEntity: NSManagedObject {
    static var all: [DetailEntity] {
        let request: NSFetchRequest<DetailEntity> = DetailEntity.fetchRequest()
        guard let favories = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return favories
    }
    
    static func deleteAllDetails() {
        let deleteFetchRequest = NSBatchDeleteRequest(fetchRequest: DetailEntity.fetchRequest())
        let _ = try? AppDelegate.viewContext.execute(deleteFetchRequest)
    }
}
