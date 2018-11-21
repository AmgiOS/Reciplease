//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Amg on 30/09/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipleaseTests: XCTestCase {
    
    //MARK: - Get Recipe
    func testGetRecipeShouldPostFailedCallbackIfError() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.error)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        recipeService.getRecipe(ingredients: [""]) { (success, recipe) in
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipeShouldPostFailedCallbackIfIncorrectData() {
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        recipeService.getRecipe(ingredients: [""]) { (success, recipe) in
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldPostFailedCallbackIncorrectResponseAndCorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.recipeCorrect, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        recipeService.getRecipe(ingredients: [""]) { (success, recipe) in
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldPostFailedCallbackNilDataAndCorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        recipeService.getRecipe(ingredients: [""]) { (success, recipe) in
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldPostFailedCallbackIncorrectDataAndCorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        recipeService.getRecipe(ingredients: [""]) { (success, recipe) in
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldPostSuccessCallbackRecipe() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.recipeCorrect, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        recipeService.getRecipe(ingredients: [""]) { (success, recipe) in
            XCTAssertTrue(success)
            XCTAssertNotNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    //MARK: - Details Recipe
    func testGetDetailsShouldPostFailedCallbackIfError() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.error)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        recipeService.getDetailsRecipe(id: "") { (success, details) in
            XCTAssertFalse(success)
            XCTAssertNil(details)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetailsShouldPostFailedCallbackIfNil() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        recipeService.getDetailsRecipe(id: "") { (success, details) in
            XCTAssertFalse(success)
            XCTAssertNil(details)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetailsShouldPostFailedCallbackIfIncorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        recipeService.getDetailsRecipe(id: "") { (success, details) in
            XCTAssertFalse(success)
            XCTAssertNil(details)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetailsShouldPostFailedCallbackIfIncorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.detailsCorrect, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        recipeService.getDetailsRecipe(id: "") { (success, details) in
            XCTAssertFalse(success)
            XCTAssertNil(details)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetailsShouldPostSuccessCallback() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.detailsCorrect, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeService = RecipeService(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        recipeService.getDetailsRecipe(id: "") { (success, details) in
            XCTAssertTrue(success)
            XCTAssertNotNil(details)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
