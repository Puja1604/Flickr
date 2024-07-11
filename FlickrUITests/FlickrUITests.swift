//
//  FlickrUITests.swift
//  FlickrUITests
//
//  Created by Puja Gogineni on 7/11/24.
//

import XCTest

class FlickrUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments = ["-reset"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testSearchAndDisplayImages() {
        let searchField = app.searchFields["Search"]
        
        // Check the search field exists and tap it
        XCTAssertTrue(searchField.exists, "The search field does not exist.")
        searchField.tap()
        
        // Enter text in the search bar
        searchField.typeText("test")
        app.keyboards.buttons["Search"].tap()
        
        // Verify that images are displayed
        let images = app.scrollViews.otherElements.images
        XCTAssertTrue(images.count > 0, "No images are displayed.")
    }
    
    func testImageNavigation() {
        let searchField = app.searchFields["Search"]
        
        // Check the search field exists and tap it
        XCTAssertTrue(searchField.exists, "The search field does not exist.")
        searchField.tap()
        
        // Enter text in the search bar
        searchField.typeText("test")
        app.keyboards.buttons["Search"].tap()
        
        // Wait for loading to finish
        let loadingIndicator = app.activityIndicators["ProgressView"]
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == false"), object: loadingIndicator)
        let waitResult = XCTWaiter().wait(for: [expectation], timeout: 10)
        XCTAssertEqual(waitResult, .completed, "Failed to load images in time")
        
        // Tap on the first image
        let firstImage = app.scrollViews.otherElements.images.firstMatch
        XCTAssertTrue(firstImage.exists, "The first image does not exist.")
        firstImage.tap()
        
        let shareButton = app.buttons["Share"]
        XCTAssertTrue(shareButton.exists)
    }
}
