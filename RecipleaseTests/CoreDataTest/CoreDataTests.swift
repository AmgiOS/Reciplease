//
//  CoreDataTests.swift
//  RecipleaseTests
//
//  Created by Amg on 21/10/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class CoreDataTests: XCTestCase {
    
    //MARK: - Vars
    var container: NSPersistentContainer!
    
    //MARK: - Tests Life Cycle
    override func setUp() {
        super.setUp()
        container = AppDelegate.persistentContainer
    }
    
    override func tearDown() {
        Recipe.deleteAllData()
        Ingredient.deleteAllIngredients()
        DetailEntity.deleteAllDetails()
        container = nil
        super.tearDown()
    }
    
    //MARK: - Helper Methods
    private func insertTodoItem(into managedObjectContext: NSManagedObjectContext) {
        let newTodoItem = Recipe(context: managedObjectContext)
        let ingredientToDoItem = Ingredient(context: managedObjectContext)
        let detailsToDoItem = DetailEntity(context: managedObjectContext)
        newTodoItem.name = "Chili"
        ingredientToDoItem.name = "Coco"
        detailsToDoItem.list = "milk"
    }
    
    //MARK: - Unit Tests
    func testInsertManyToDoItemsInPersistentContainer() {
        for _ in 0 ..< 100 {
            insertTodoItem(into: container.newBackgroundContext())
        }
        XCTAssertNoThrow(try container.newBackgroundContext().save())
    }
    
    func testDeleteAllToDoItemsInPersistentContainer() {
        Recipe.deleteAllData()
        Ingredient.deleteAllIngredients()
        DetailEntity.deleteAllDetails()
        XCTAssertEqual(Recipe.all, [])
        XCTAssertEqual(Ingredient.all, [])
        XCTAssertEqual(DetailEntity.all, [])
    }
}
